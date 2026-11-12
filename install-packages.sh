#!/bin/bash
set -e

echo "=== Installing packages ==="

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
    man-db \
    greetd \
    power-profiles-daemon \
    os-prober \
    evtest \
    exfatprogs \
    wl-clipboard \
    wtype

echo "Installing Shell & CLI packages..."
sudo pacman -S --needed \
    starship \
    zoxide \
    stow \
    wget \
    fish \
    fzf \
    tmux \
    git \
    yazi

echo "Installing Development packages..."
sudo pacman -S --needed \
    bun \
    neovim \
    kitty \
    lazygit \
    github-cli \
    yarn \
    fd \
    tree-sitter-cli \
    uv \
    npm \
    code \
    matugen

echo "Installing System Tools packages..."
sudo pacman -S --needed \
    timeshift

echo "Installing Audio packages..."
sudo pacman -S --needed \
    pipewire \
    pipewire-pulse \
    wireplumber \
    pavucontrol

echo "Installing Media & Graphics packages..."
sudo pacman -S --needed \
    vlc \
    imagemagick \
    imv \
    file-roller \
    tesseract \
    tesseract-data-eng \
    tesseract-data-vie \
    zbar \
    img2pdf

if command -v yay &>/dev/null || command -v pacman &>/dev/null; then
    if ! command -v yay &>/dev/null; then
        echo "Installing yay from AUR..."
        sudo pacman -S --needed yay
    fi

    echo "Installing AUR Helpers & Tools..."
    yay -S --needed \
        dsearch-bin

    echo "Installing GUI & Theming packages..."
    yay -S --needed \
        gtk-engine-murrine \
        tela-circle-icon-theme-dracula

    echo "Installing Display & Graphics packages..."
    yay -S --needed \
        greetd-dms-greeter-git

    echo "Installing AUR applications..."
    yay -S --needed \
        spicetify-bin \
        spotify \
        tmuxinator \
        localsend-bin \
        zen-browser-bin \
        niri \
        cava \
        onlyoffice-bin \
        brave-origin-nightly-bin \
        bluevein-bin \
        yaak \
        xdg-terminal-exec-git

    echo "Installing GUI Tools packages..."
    sudo pacman -S --needed \
        nwg-look \
        fcitx5-configtool \
        fcitx5-unikey \
        thunar \
        thunar-archive-plugin \
        thunar-volman \
        tumbler \
        fcitx5 \
        noto-fonts \
        noto-fonts-emoji \
        ttf-jetbrains-mono-nerd

    echo "Installing Display & Graphics packages..."
    sudo pacman -S --needed \
        dux-shell \
        dux-gop \
        nvidia-open \
        nvidia-utils \
        nvidia-settings \
        xwayland-satellite
fi

echo "Installing Applications..."
sudo pacman -S --needed \
    opencode

echo "=== Package installation complete ==="
