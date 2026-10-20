#!/usr/bin/env bash
# lib.sh : fonctions communes, sourcées par setup.sh

LOGFILE="/tmp/fedora-setup.log"

ok()   { echo -e "\033[32mOK\033[0m"; }
fail() { echo -e "\033[31mERREUR\033[0m"; }

# run <commande...> : exécute, journalise, affiche OK/ERREUR
run() {
    if "$@" >> "$LOGFILE" 2>&1; then ok; else fail; fi
}

check_pkg() { rpm -q "$1" &>/dev/null; }
add_pkg()   { sudo dnf install -y "$1"; }
del_pkg()   { sudo dnf remove -y "$1"; }

# process_list <fichier> : lit les lignes "add:x" / "del:x"
process_list() {
    local file="$1" line p
    while read -r line; do
        [[ -z "$line" || "$line" == \#* ]] && continue   # ignore vides et commentaires
        case "$line" in
            add:*) p=${line#add:}
                   check_pkg "$p" || { echo -n "  + $p : "; run add_pkg "$p"; } ;;
            del:*) p=${line#del:}
                   check_pkg "$p" && { echo -n "  - $p : "; run del_pkg "$p"; } ;;
        esac
    done < "$file"
}

# Utilise "$(id -un)" plutôt que $USER (peut être vide selon l'environnement)
