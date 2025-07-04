#!/usr/bin/env bash

if pgrep -x "polybar" > /dev/null; then
    pkill -x polybar
else
    polybar main &
fi

