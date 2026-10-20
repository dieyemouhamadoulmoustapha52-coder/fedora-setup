#!/usr/bin/env bash
# 01 - Système : config dnf, mises à jour, hostname, fuseau horaire
# Idempotent : peut être relancé sans risque.

echo "01- Système"

# dnf : téléchargements parallèles (seulement si absent)
conf=/etc/dnf/dnf.conf
if ! grep -q '^max_parallel_downloads=' "$conf"; then
    echo -n "  max_parallel_downloads : "
    run bash -c "echo 'max_parallel_downloads=10' | sudo tee -a $conf"
fi

# Fuseau horaire
if [[ "$(timedatectl show -p Timezone --value)" != "Africa/Dakar" ]]; then
    echo -n "  fuseau Africa/Dakar : "
    run sudo timedatectl set-timezone Africa/Dakar
fi

# Mise à jour complète
echo -n "  mise à jour : "
run sudo dnf upgrade -y --refresh
