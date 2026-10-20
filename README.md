# fedora-setup

Script de post-installation pour Fedora (testé sur Fedora 44 KDE).
Idempotent : on peut le relancer sans risque, il ne refait que ce qui manque.

## Utilisation
    git clone <url-du-depot> ~/fedora-setup && cd ~/fedora-setup
    ./setup.sh

## Structure
- `setup.sh`    : point d'entrée, lance les modules dans l'ordre
- `scripts/`    : un module par thème (01 à 08) + `lib.sh` (fonctions communes)
- `lists/`      : les données (`add:paquet` / `del:paquet`)
- `dotfiles/`   : mes fichiers de config (shell, git, vscode, kde)
- `docs/`       : documentation détaillée

## Règles
- Aucun secret dans ce dépôt (voir `.gitignore`)
- Toujours tester dans une VM avant la vraie machine
