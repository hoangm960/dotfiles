#!/bin/bash

MONITOR_NAME="eDP-1"

current_scale=$(hyprctl monitors | grep "Monitor $MONITOR_NAME" -A 10 | grep "scale:" | awk '{print $2}')

if [ "$current_scale" == "1.00" ]; then
    new_scale="1.25"
else
    new_scale="1"
fi

hyprctl keyword monitor "$MONITOR_NAME,preferred,auto,$new_scale"
