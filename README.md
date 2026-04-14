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

---

## Install Packages Script

After setting up the system, install all packages from this dotfiles:

```bash
./install-packages.sh
```

The script installs packages from official Arch repos and AUR, grouped by category:

Uses `--needed` flag - already-installed packages are skipped. Requires yay (installed automatically if missing).

---

## Secure Boot

Use the automated script:

```bash
# Interactive mode (with confirmations)
./secureboot.sh

# Non-interactive mode (auto-run all steps)
./secureboot.sh -y
```

**Prerequisite**: Change Secure Boot to Setup Mode in firmware before running.
