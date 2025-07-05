#!/bin/sh

# Ensure DISPLAY is set correctly
if [ -z "$DISPLAY" ]; then
    export DISPLAY=:0
fi

if [ -f "$HOME/.xprofile" ]; then
    . "$HOME/.xprofile"
fi

# Disable DPMS and screen blanking
xrandr --output eDP-1 --set "DPMS" "off" 2>/dev/null
xset s off
xset -dpms
xset s noblank


# Start i3 window manager
exec i3

