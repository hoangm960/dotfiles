#!/bin/bash

if ! command -v powerprofilesctl &> /dev/null || \
   ! command -v pamixer &> /dev/null || \
   ! command -v hyprctl &> /dev/null; then
    echo "Error: Required commands (powerprofilesctl, pamixer, hyprctl) not found."
    echo "Please ensure they are installed and in your PATH."
    exit 1
fi

current_profile=$(powerprofilesctl get)

if [ "$current_profile" == "power-saver" ]; then
    powerprofilesctl set performance
    pamixer --unmute
    brightnessctl set 100%
    omarchy-toggle-idle
else
    powerprofilesctl set power-saver
    pamixer --mute
    brightnessctl set 70%
    omarchy-toggle-idle
fi
