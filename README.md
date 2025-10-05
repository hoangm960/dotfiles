# Mengrch

> Yes I use arch btw

## Install

[Install Omarchy](https://learn.omacom.io/2/the-omarchy-manual/50/getting-started)

```bash
sudo pacman -S needed base-devel git
git clone https://aur.archlinux.org/yay.git
```

```bash
yay -S stow
git clone https://github.com/hoangm960/dotfiles.git
cd dotfiles
stow .
```

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

## Things to do

- [x] Hyprland
- [x] Waybar
- [ ] Walker
- [x] GTK
- [x] Fish
- [x] Neovim
- [x] grub
