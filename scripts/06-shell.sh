echo "06- Shell et Terminal"

# 1. Installer zsh, tmux et mycli si absents
for pkg in zsh tmux mycli; do
    if ! rpm -q "$pkg" &>/dev/null; then
        echo -n "  + $pkg : "
        run sudo dnf install -y "$pkg"
    fi
done

# 2. Installer Oh My Zsh si absent
if [[ ! -d ~/.oh-my-zsh ]]; then
    echo -n "  + Oh My Zsh : "
    run sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
fi

# 3. Installer le thème Powerlevel10k si absent
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]]; then
    echo -n "  + Powerlevel10k : "
    run git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# 4. Déployer les dotfiles shell (liens symboliques)
echo -n "  + Déploiement des dotfiles shell : "
[[ -f "$ICI/dotfiles/shell/.zshrc" ]] && ln -sf "$ICI/dotfiles/shell/.zshrc" ~/.zshrc
[[ -f "$ICI/dotfiles/shell/.p10k.zsh" ]] && ln -sf "$ICI/dotfiles/shell/.p10k.zsh" ~/.p10k.zsh
[[ -f "$ICI/dotfiles/shell/tmux.conf" ]] && ln -sf "$ICI/dotfiles/shell/tmux.conf" ~/.tmux.conf
[[ -f "$ICI/dotfiles/shell/.myclirc" ]] && ln -sf "$ICI/dotfiles/shell/.myclirc" ~/.myclirc
ok

# 5. Définir Zsh comme shell par défaut si ce n'est pas déjà fait
if [[ "$SHELL" != */zsh ]]; then
    echo -n "  + Définition de Zsh comme shell par défaut : "
    run chsh -s "$(which zsh)"
fi
