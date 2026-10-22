echo "08- Configuration KDE Plasma (Thèmes, Raccourcis, Panneaux)"

KDE_CONFIG_DIR="$HOME/.config"

if [[ -d "$ICI/dotfiles/kde" ]]; then
    mkdir -p "$KDE_CONFIG_DIR"
    
    # Restauration des fichiers de configuration KDE
    for cfg in kdeglobals kwinrc kglobalshortcutsrc plasma-org.kde.plasma.desktop-appletsrc konsolerc; do
        if [[ -f "$ICI/dotfiles/kde/$cfg" ]]; then
            echo -n "  + Restauration de $cfg : "
            cp "$ICI/dotfiles/kde/$cfg" "$KDE_CONFIG_DIR/$cfg"
            ok
        fi
    done
    
    # Recharger KWin et Plasma pour appliquer les changements immédiatement
    if command -v kwin_x11 &>/dev/null || command -v kwin_wayland &>/dev/null; then
        qdbus org.kde.KWin /KWin reconfigure 2>/dev/null || true
    fi
else
    echo "  ! Aucun dossier de configuration KDE trouvé dans le dépôt."
fi
