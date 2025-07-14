#!/usr/bin/env bash

if pgrep -x "picom" > /dev/null; then
    pkill -x picom
else
    picom &
fi

