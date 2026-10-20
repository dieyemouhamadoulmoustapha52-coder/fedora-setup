echo "03- Paquets et Codecs"

# Paquets DNF classiques et codecs
[[ -f "$ICI/lists/packages.list" ]] && process_list "$ICI/lists/packages.list"
[[ -f "$ICI/lists/codec.list" ]]    && process_list "$ICI/lists/codec.list"

# Paquets Flatpak
if command -v flatpak &>/dev/null && [[ -f "$ICI/lists/flatpak.list" ]]; then
    while read -r line; do
        [[ -z "$line" || "$line" == \#* ]] && continue
        case "$line" in
            add:*) p=${line#add:}
                if ! flatpak list --app | grep -q "$p"; then
                    echo -n "  + Flatpak $p : "
                    run flatpak install -y flathub "$p"
                fi ;;
        esac
    done < "$ICI/lists/flatpak.list"
fi
