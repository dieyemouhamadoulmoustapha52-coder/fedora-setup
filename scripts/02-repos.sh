echo "02- Dépôts"

# RPM Fusion Free & Non-Free
if ! rpm -q rpmfusion-free-release &>/dev/null; then
    echo -n "  + RPM Fusion : "
    run sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$\(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/non-free/fedora/rpmfusion-non-free-release-$\(rpm -E %fedora).noarch.rpm
fi

# Flathub
if ! flatpak remote-list | grep -q flathub; then
    echo -n "  + Flathub : "
    run flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fi
