#!/usr/bin/env bash
# setup.sh : point d'entrée. Lance les modules scripts/0*.sh dans l'ordre.
set -uo pipefail

ICI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export ICI
source "$ICI/scripts/lib.sh"

# Pas en root : les dotfiles iraient dans /root. Le script appelle sudo si besoin.
if [[ $(id -u) -eq 0 ]]; then
    echo "Lance ce script SANS sudo."; exit 1
fi

# Vérifie qu'on est bien sur Fedora
FC0=$(rpm -E %fedora)
[[ $FC0 =~ ^[0-9]+$ ]] || { echo "Fedora non détectée."; exit 1; }

echo "Journal : tail -f $LOGFILE"

for s in "$ICI"/scripts/0*.sh; do
    echo -e "\n\033[36m== $(basename "$s") ==\033[0m"
    source "$s"
done
