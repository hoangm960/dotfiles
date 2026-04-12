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

## Dank Linux (Optional)

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

## Install Niri

A scrollable-tiling Wayland compositor.

### 1. Install Niri

```bash
# Arch Linux
yay -S niri

# Or from source (requires Rust)
git clone https://github.com/niri-wm/niri.git
cd niri
cargo build --release
sudo cp target/release/niri /usr/local/bin/
```

### 2. Install Dependencies

```bash
# Required
yay -S waybar fuzzel wofi grim wl-clipboard

# Optional but recommended
yay -S polkit-kde-agent libdbusmenu-glib networkmanager
```

### 3. Configure Login Manager

If using greetd:

```bash
sudo pacman -S greetd
sudo systemctl enable greetd
```

Create `~/.config/niri/config.kdl` (see [niri config](https://github.com/niri-wm/niri/blob/main/doc/config.md))

### 4. Start Niri

Log out and select Niri from your display manager, or add to `~/.xinitrc`:

```bash
exec niri
```

### 5. Clone Dotfiles

```bash
yay -S stow
git clone https://github.com/hoangm960/dotfiles.git
cd dotfiles
stow .
```

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
