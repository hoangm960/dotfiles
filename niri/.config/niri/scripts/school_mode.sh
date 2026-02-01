#!/bin/bash

current_profile=$(powerprofilesctl get)

if [ "$current_profile" == "power-saver" ]; then
    powerprofilesctl set performance
    dms ipc call audio setvolume 100
    brightnessctl set 100%
    brightnessctl -d asus::kbd_backlight set 3
else
    powerprofilesctl set power-saver
    dms ipc call audio setvolume 0
    brightnessctl set 50%
    brightnessctl -d asus::kbd_backlight set 0
fi
