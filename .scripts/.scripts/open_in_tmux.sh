#!/bin/bash
# Currently this is only being used with ranger
# as a way to open files from ranger into my tmux sessions

# Check if the file exists
FILE="$1"
if [[ ! -f "$FILE" ]]; then
  echo "Error: File does not exist."
  exit 1
fi

# tmux session name
SESSION="Jelqed"

# Open the file in Neovim within the tmux session
tmux new-window -t "$SESSION" "nvim '$FILE'" \;

# Get the last window number in tmux session
WINDOW_NUM=$(tmux list-windows -t "$SESSION" | tail -n 1 | cut -d: -f1)

# Switch to the newly created window
tmux select-window -t "$SESSION:$WINDOW_NUM"

# Switch to i3 workspace 1
i3-msg workspace 1

