#!/bin/bash
set -e

echo "=== Installing packages ==="

# System & Base
echo "Installing System & Base packages..."
sudo pacman -S --needed \
    base \
    grub \
    intel-ucode \
    sof-firmware \
    zram-generator \
    ufw \
    bluez \
    bluez-utils \
    brightnessctl \
    iwd \
    ntfs-3g \
    sbctl \
    man-db

# Shell & CLI
echo "Installing Shell & CLI packages..."
sudo pacman -S --needed \
    starship \
    zoxide \
    stow \
    wget \
    fish \
    fzf \
    tmux \
    git

# Development
echo "Installing Development packages..."
sudo pacman -S --needed \
    bun \
    neovim \
    kitty \
    lazygit \
    github-cli \
    yarn \
    sassc \
    cli11 \
    qt6-shadertools \
    fd \
    tree-sitter-cli \
    uv \
    npm

# System Tools
echo "Installing System Tools packages..."
sudo pacman -S --needed \
    timeshift

# AUR Packages (requires yay)
if command -v yay &>/dev/null || command -v pacman &>/dev/null; then
    # Check if yay is available, install if not
    if ! command -v yay &>/dev/null; then
        echo "Installing yay from AUR..."
        sudo pacman -S --needed yay
    fi

    # AUR Helpers & Tools
    echo "Installing AUR Helpers & Tools..."
    yay -S --needed \
        cpptrace-debug \
        dsearch-bin \
        yay-debug

    # GUI & Theming (AUR)
    echo "Installing GUI & Theming packages..."
    yay -S --needed \
        gtk-engine-murrine \
        tela-circle-icon-theme-dracula

    # Display & Graphics (AUR)
    echo "Installing Display & Graphics packages..."
    yay -S --needed \
        greetd-dms-greeter-git

    # Applications (AUR)
    echo "Installing AUR applications..."
    yay -S --needed \
        spicetify-bin \
        spotify \
        tmuxinator \
        localsend-bin \
        zen-browser-bin \
        niri \
        quickshell-git \
        cava \
        onlyoffice-bin

    # GUI Tools (official repos)
    echo "Installing GUI Tools packages..."
    sudo pacman -S --needed \
        nwg-look \
        fcitx5-configtool \
        fcitx5-unikey

    # Display & Graphics (official)
    echo "Installing Display & Graphics packages..."
    sudo pacman -S --needed \
        dms-shell \
        nvidia-open \
        wayland-protocols
fi

# Applications (official)
echo "Installing Applications..."
sudo pacman -S --needed \
    chromium \
    opencode

echo "=== Package installation complete ==="
