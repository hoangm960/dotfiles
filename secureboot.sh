#!/bin/bash
set -e

INTERACTIVE=true
if [[ "$1" == "-y" || "$1" == "--yes" ]]; then
    INTERACTIVE=false
fi

confirm() {
    if [[ "$INTERACTIVE" == false ]]; then
        return 0
    fi
    read -p "$1 [y/N] " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

check_status() {
    echo "=== Secure Boot Status ==="
    if command -v sbctl &>/dev/null; then
        echo -e "\n--- sbctl status ---"
        sudo sbctl status 2>/dev/null || echo "sbctl not configured"
        echo -e "\n--- sbctl verify ---"
        sudo sbctl verify 2>/dev/null || echo "no files to verify"
    else
        echo "sbctl not installed"
    fi
    echo -e "\n--- GRUB TPM module ---"
    if [[ -f /boot/grub/x86_64-efi/tpm.mod ]]; then
        echo "Present: /boot/grub/x86_64-efi/tpm.mod"
    else
        echo "Not found: /boot/grub/x86_64-efi/tpm.mod"
    fi
    echo -e "\n--- Keys directory ---"
    if [[ -d /etc/sbctl/keys ]]; then
        echo "Present: /etc/sbctl/keys"
    else
        echo "Not found: /etc/sbctl/keys"
    fi
    echo "==========================="
}

check_status

if ! confirm "Continue with Secure Boot setup?"; then
    echo "Aborted."
    exit 0
fi

echo "Installing sbctl and grub..."
sudo pacman -S --needed sbctl grub

if confirm "Reinstall GRUB with TPM module?"; then
    sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --modules="tpm" --disable-shim-lock
fi

if confirm "Create and enroll Secure Boot keys?"; then
    sudo sbctl create-keys
    sudo sbctl enroll-keys --microsoft
fi

if confirm "Verify and auto-sign unsigned files?"; then
    sudo sbctl verify | sudo sed 's/✗ /sbctl sign -s /e'
fi

if confirm "Rebuild GRUB config?"; then
    sudo grub-mkconfig -o /boot/grub/grub.cfg
fi

echo "Secure Boot setup complete!"