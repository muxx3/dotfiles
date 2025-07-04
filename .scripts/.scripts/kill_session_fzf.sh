#!/usr/bin/env bash

# Get current session name
current=$(tmux display-message -p '#S')

# List sessions and select one
target=$(tmux list-sessions -F '#S' | fzf --prompt="Kill session > ")
[ -z "$target" ] && exit

# If you're killing the current session, pick another one to switch to
if [ "$target" = "$current" ]; then
  alt=$(tmux list-sessions -F '#S' | grep -v "^$target$" | head -n 1)
  [ -n "$alt" ] && tmux switch-client -t "$alt"
fi

# Kill selected session
tmux kill-session -t "$target"

