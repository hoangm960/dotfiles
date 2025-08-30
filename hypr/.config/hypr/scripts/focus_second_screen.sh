#!/bin/bash

if hyprctl monitors -j | jq -e 'any(.name == "HDMI-A-1")' >/dev/null; then
    echo "Monitor HDMI-A-1 found. Dispatching workspace 1."
    hyprctl dispatch workspace 11
else
    echo "Monitor HDMI-A-1 not found."
fi
