#!/usr/bin/env bash

PERCENT=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | awk '/percentage:/ {print $2}')
STATE=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | awk '/state:/ {print $2}')

if [[ "$STATE" == "charging" ]]; then
    ICON="C"
elif [[ "$STATE" == "fully-charged" ]]; then
    ICON="F"
else
    ICON="D"
fi

echo "$ICON $PERCENT"

