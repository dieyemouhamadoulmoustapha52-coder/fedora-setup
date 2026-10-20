# fedora-setup

Script de post-installation pour Fedora (testé sur Fedora 44 KDE).
Idempotent : on peut le relancer sans risque, il ne refait que ce qui manque.

## Utilisation
    git clone <url-du-depot> ~/fedora-setup && cd ~/fedora-setup
    ./setup.sh

## Structure
- `setup.sh`      : point d'entrée, lance les modules dans l'ordre
- `scripts/`      : un module par thème (01 à 08) + `lib.sh` (fonctions communes)
- `lists/`        : les données (`packages.list`, `vscode-extensions.list`, etc.)
- `dotfiles/`     : fichiers de configuration (shell: `.zshrc`, `.p10k.zsh`, `tmux.conf`, etc.)
- `docs/`         : documentation détaillée

## Modules inclus
- `01-system.sh`  : Optimisation DNF, fuseau horaire, mises à jour
- `05-git-ssh.sh` : Configuration Git et génération de clé SSH Ed25519
- `06-shell.sh`   : Installation de Zsh, Oh My Zsh, Powerlevel10k, Tmux, MyCLI et déploiement des dotfiles

## Règles
- Aucun secret dans ce dépôt (voir `.gitignore`)
- Toujours tester dans une VM avant la vraie machine
