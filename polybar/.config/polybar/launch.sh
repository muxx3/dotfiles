#!/usr/bin/env bash

# Kill any existing polybar instances
killall -q polybar

# Wait until all polybar processes have been shut down
while pgrep -u "$UID" -x polybar >/dev/null; do
    sleep 0.2
done

# Launch your main bar
polybar main & disown

