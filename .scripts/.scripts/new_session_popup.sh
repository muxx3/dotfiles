#!/usr/bin/env bash
# new_session_popup.sh

# Show a blue prompt using ANSI color 117 (light blue)
echo -ne "\033[38;5;117m New/Active > \033[0m"

# Read user input character-by-character to detect Escape
session_name=""
while IFS= read -r -n1 -s char; do
  case "$char" in
    '')  # Enter key
      break
      ;;
    $'\e')  # ESC key
      echo -e "\n\033[38;5;244m Canceled.\033[0m"
      exit 0
      ;;
      $'\177')  # Backspace
      if [ -n "$session_name" ]; then
        session_name="${session_name%?}"
        echo -ne "\b \b"  # Move back, overwrite, move back again
      fi
      ;;
    *)  # Append to session name
      session_name+="$char"
      printf "%s" "$char"
      ;;
  esac
done

echo

if [ -z "$session_name" ]; then
  echo -ne "\033[38;5;220m No name entered.\033[0m"
  read -n 1 -s -r -p " Press any key to close..."
  exit 1
fi

# Check if session already exists
if tmux has-session -t "$session_name" 2>/dev/null; then
  echo -ne "\033[38;5;220m '$session_name' already exists.\033[0m"
  read -n 1 -s -r -p " Press any key to switch..."
else
  # Create the session detached
  tmux new-session -d -s "$session_name"
fi

# Switch to the new session
tmux switch-client -t "$session_name"

