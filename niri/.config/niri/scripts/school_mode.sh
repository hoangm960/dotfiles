#!/bin/bash

current_profile=$(powerprofilesctl get)

if [ "$current_profile" == "power-saver" ]; then
    powerprofilesctl set performance
    dms ipc call audio setvolume 100
    brightnessctl set 100%
    brightnessctl -d asus::kbd_backlight set 3
    niri msg output eDP-1 mode 1920x1080@144.003
else
    powerprofilesctl set power-saver
    dms ipc call audio setvolume 0
    brightnessctl set 50%
    brightnessctl -d asus::kbd_backlight set 0
    niri msg output eDP-1 mode 1920x1080@60.004
fi
