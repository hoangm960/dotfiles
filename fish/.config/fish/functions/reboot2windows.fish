function reboot2windows --description 'Find and reboot into the Windows GRUB menu entry.'
    set windows_title (grep -i "menuentry " /boot/grub/grub.cfg | grep -i windows | head -n 1 | cut -d\' -f2)

    if test -z "$windows_title"
        echo "Error: Windows menu entry not found in grub.cfg." >&2
        return 1
    end

    echo "Setting GRUB to boot: $windows_title"
    sudo grub-reboot "$windows_title"

    if test $status -eq 0
        echo "Rebooting into Windows..."
        sudo reboot
    else
        echo "Error: grub-reboot failed. Check sudo permissions and GRUB environment file." >&2
        return 1
    end
end
