#!/usr/bin/env bash
# 05 - Git, clé SSH, GitHub CLI
# Idempotent : peut être relancé sans risque.

echo "05- Git et SSH"

git config --global init.defaultBranch main

if [[ -z "$(git config --global user.name)" ]]; then
    read -rp "  Nom Git : " n;    git config --global user.name "$n"
fi
if [[ -z "$(git config --global user.email)" ]]; then
    read -rp "  Email Git : " e;  git config --global user.email "$e"
fi

# Clé SSH : seulement si elle n'existe pas
if [[ ! -f ~/.ssh/id_ed25519 ]]; then
    echo -n "  clé SSH ed25519 : "
    run ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519
fi
