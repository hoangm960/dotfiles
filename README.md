# Mengrch

> Yes I use arch btw

## Arch Linux Installation

### 1. Download ISO

Download the latest Arch Linux ISO from [archlinux.org/download](https://archlinux.org/download/)

### 2. Create Bootable USB

```bash
# On Linux
sudo dd if=archlinux-2026.03.01-x86_64.iso of=/dev/sdX bs=4M status=progress oflag=sync

# On macOS
sudo dd if=archlinux-2026.03.01-x86_64.iso of=/dev/rdiskN bs=4M

# On Windows - use Rufus or Ventoy
```

Replace `/dev/sdX` with your actual USB device (check with `lsblk`)

### 3. Boot into Live Environment

- Insert USB and boot from it
- Press F2/F12/Del to access BIOS/UEFI boot menu
- Select the USB drive to boot into Arch live environment
- Confirm UEFI mode: `ls /sys/firmware/efi/efivars`

### 4. Connect to Internet

```bash
# For WiFi
iwctl
# Then: station wlan0 connect YOUR_NETWORK_NAME

# Or use NetworkManager
nmcli device wifi connect YOUR_NETWORK_NAME password YOUR_PASSWORD
```

Verify connection:

```bash
ping archlinux.org
```

### 5. Run archinstall

```bash
archinstall
```

**Recommended options:**

- **Mirrors**: Select best mirrors for your region
- **Disk**: Use `Erase disk` with `ext4` or `btrfs`
- **Bootloader**: GRUB (UEFI)
- **Profile**: Desktop (GNOME or minimal)
- **Users**: Create your user with sudo privileges
- **Network**: Use NetworkManager

### 6. First Boot

After installation completes:

```bash
reboot
```

Remove USB and log into your new system.

### 7. Post-Installation Setup

```bash
# Update system
sudo pacman -Syu

# Install base packages
sudo pacman -S base-devel git curl wget

# Install yay (AUR helper)
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

---

## Dank Linux

A modern desktop suite with DankMaterialShell (DMS). Works with Niri, Hyprland, and other Wayland compositors.

### Quick Install

```bash
curl -fsSL https://install.danklinux.com | sh
```

### Manual Install (if DMS already installed)

```bash
dms setup
```

### Individual Components

```bash
# DankMaterialShell
yay -S dms-git

# System monitor
yay -S dgop

# File search
yay -S dsearch

# Color theming
yay -S matugen
```

---

## Install Packages Script

After setting up the system, install all packages from this dotfiles:

```bash
./install-packages.sh
```

The script installs packages from official Arch repos and AUR, grouped by category:
- **System & Base**: base, grub, intel-ucode, sof-firmware, zram-generator, ufw, bluez, bluez-utils, brightnessctl
- **Shell & CLI**: starship, zoxide, stow, wget
- **Development**: bun, neovim, kitty, lazygit, github-cli, yarn, luarocks, sassc, cli11, qt6-shadertools, fd, tree-sitter-cli, uv
- **System Tools**: timeshift
- **AUR Tools**: yay, cpptrace-debug, dsearch-bin, yay-debug
- **GUI & Theming**: gtk-engine-murrine, tela-circle-icon-theme-dracula, nwg-look, fcitx5
- **Display & Graphics**: dms-shell, nvidia-open, wayland-protocols, greetd-dms-greeter-git
- **Applications**: chromium, spotify, spicetify-bin, opencode, tmuxinator, localsend-bin, zen-browser-bin

Uses `--needed` flag - already-installed packages are skipped. Requires yay (installed automatically if missing).

---

## Secure Boot

1. Change Secure Boot to Setup Mode in Firmware
2. Install required packages:

```bash
sudo pacman -S sbctl
sudo pacman -S grub
```

3. Reinstall GRUB

```bash
sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --modules="tpm" --disable-shim-lock
```

4. Create and enroll keys

```bash
sudo sbctl create-keys
sudo sbctl enroll-keys --microsoft
```

Then verify with

```bash
sudo sbctl verify
```

_Shortcut:_

```bash
sudo sbctl verify | sed 's/✗ /sbctl sign -s /e'
```

5. Rebuild GRUB and reboot

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```
