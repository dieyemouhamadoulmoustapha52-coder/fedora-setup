echo "09- Vivaldi Browser Configuration"

# Détection du chemin du profil (Flatpak vs Natif RPM)
VIVALDI_PROFILE=""
if [[ -d "$HOME/.var/app/com.vivaldi.Vivaldi/config/vivaldi/Default" ]]; then
    VIVALDI_PROFILE="$HOME/.var/app/com.vivaldi.Vivaldi/config/vivaldi/Default"
elif [[ -d "$HOME/.config/vivaldi/Default" ]]; then
    VIVALDI_PROFILE="$HOME/.config/vivaldi/Default"
elif [[ -d "$HOME/.config/Vivaldi/Default" ]]; then
    VIVALDI_PROFILE="$HOME/.config/Vivaldi/Default"
fi

if [[ -n "$VIVALDI_PROFILE" ]]; then
    mkdir -p "$VIVALDI_PROFILE"
    
    # Restauration des préférences si présentes dans le dépôt
    if [[ -f "$ICI/dotfiles/vivaldi/Preferences" ]]; then
        echo -n "  + Restauration Préférences Vivaldi : "
        cp "$ICI/dotfiles/vivaldi/Preferences" "$VIVALDI_PROFILE/Preferences"
        ok
    fi
    
    # Restauration des favoris si présents dans le dépôt
    if [[ -f "$ICI/dotfiles/vivaldi/Bookmarks" ]]; then
        echo -n "  + Restauration Favoris Vivaldi : "
        cp "$ICI/dotfiles/vivaldi/Bookmarks" "$VIVALDI_PROFILE/Bookmarks"
        ok
    fi
else
    echo "  ! Profil Vivaldi non trouvé. Lancez Vivaldi une première fois pour initialiser le profil."
fi
