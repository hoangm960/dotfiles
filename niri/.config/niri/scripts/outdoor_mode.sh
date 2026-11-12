#!/bin/bash

state_dir="${XDG_STATE_HOME:-$HOME/.local/state}"
mkdir -p "$state_dir"
state_file="$state_dir/outdoor_mode.state"
builtin_sink="alsa_output.pci-0000_00_1f.3.analog-stereo"

if [[ -f "$state_file" ]]; then
    source "$state_file"

    powerprofilesctl set "${prev_profile:-performance}"
    pactl set-sink-volume "$builtin_sink" "${prev_volume:-100%}"
    brightnessctl set "${prev_brightness:-70%}"
    brightnessctl -d asus::kbd_backlight set "${prev_kbd:-3}"
    niri msg output eDP-1 mode "${prev_mode:-1920x1080@144.003}"

    rm -f "$state_file"
else
    cur_profile=$(powerprofilesctl get)
    cur_volume=$(pactl get-sink-volume "$builtin_sink" | grep -oP '\d+%' | head -n1)
    cur_brightness=$(brightnessctl get)
    cur_kbd=$(brightnessctl -d asus::kbd_backlight get)
    cur_mode=$(niri msg -j outputs | jq -r '."eDP-1" | .modes[.current_mode] | "\(.width)x\(.height)@\(.refresh_rate / 1000)"')

    [[ "$cur_profile" == "power-saver" ]] && cur_profile="performance"
    [[ "$cur_volume" == "0%" ]] && cur_volume="100%"
    [[ "$cur_kbd" == "0" ]] && cur_kbd="3"
    [[ "$cur_mode" == "1920x1080@60.004" ]] && cur_mode="1920x1080@144.003"

    cat <<EOF > "$state_file"
prev_profile=$cur_profile
prev_volume=$cur_volume
prev_brightness=$cur_brightness
prev_kbd=$cur_kbd
prev_mode=$cur_mode
EOF

    powerprofilesctl set power-saver
    pactl set-sink-volume "$builtin_sink" 0%
    brightnessctl set 30%
    brightnessctl -d asus::kbd_backlight set 0
    niri msg output eDP-1 mode 1920x1080@60.004
fi
