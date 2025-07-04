#!/usr/bin/env bash

# Directories to search
dirs="${1:-$HOME}"

# Use fzf to pick a file or directory
file=$(find "$dirs" \( -type f -o -type d \) 2>/dev/null | fzf)

# Exit if no selection
if [ -z "$file" ]; then
    echo "No file selected."
    exit 1
fi

# Detect current tmux session (if any)
if [ -n "$TMUX" ]; then
    CURRENT_SESSION=$(tmux display-message -p '#S')
else
    CURRENT_SESSION=""
fi

if [ -n "$CURRENT_SESSION" ]; then
    # Session exists, create new window
    tmux new-window -t "$CURRENT_SESSION" "nvim \"$file\""
    WINDOW_NUM=$(tmux list-windows -t "$CURRENT_SESSION" | tail -n 1 | cut -d: -f1)
    tmux select-window -t "$CURRENT_SESSION:$WINDOW_NUM"
    # Optional: i3 workspace focus (you can keep or remove)
    i3-msg workspace 1
else
    # Not in tmux, open directly
    nvim "$file"
fi

