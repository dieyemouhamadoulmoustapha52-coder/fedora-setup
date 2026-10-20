echo "04- Stack de Développement (Apache, MariaDB, PHP, Node, Podman)"

# 1. Installer Apache (httpd) et MariaDB Server
for pkg in httpd mariadb-server podman; do
    if ! rpm -q "$pkg" &>/dev/null; then
        echo -n "  + $pkg : "
        run sudo dnf install -y "$pkg"
    fi
done

# Activer et démarrer les services de base (sans bloquer si échec en mode chroot/vm)
sudo systemctl enable --now httpd 2>/dev/null || true
sudo systemctl enable --now mariadb 2>/dev/null || true

# 2. Installer PHP et ses extensions courantes pour le dev web
PHP_PACKAGES=(php php-cli php-common php-mysqlnd php-pdo php-gd php-mbstring php-xml php-json)
for php_pkg in "${PHP_PACKAGES[@]}"; do
    if ! rpm -q "$php_pkg" &>/dev/null; then
        echo -n "  + $php_pkg : "
        run sudo dnf install -y "$php_pkg"
    fi
done

# 3. Installer Composer (gestionnaire de dépendances PHP) si absent
if ! command -v composer &>/dev/null; then
    echo -n "  + Composer (PHP) : "
    run bash -c "php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\" && php composer-setup.php --install-dir=/usr/local/bin --filename=composer && rm composer-setup.php"
fi

# 4. Installer Node.js et npm si absents
if ! command -v node &>/dev/null; then
    echo -n "  + Node.js & npm : "
    run sudo dnf install -y nodejs
fi

# 5. Installer Bun (si vous l'utilisez comme vu dans vos dossiers)
if [[ ! -d "$HOME/.bun" ]]; then
    echo -n "  + Bun : "
    run curl -fsSL https://bun.sh/install | bash
fi
