#!/bin/bash

if ! command -v tmux &>/dev/null; then
  echo "Error: tmux is not installed. Please install tmux to continue."
  exit 1
fi

if tmux has-session -t "ds-bot" &>/dev/null; then
  echo "The ds-bot is already running."
else
  cd "$HOME/apps/ds-bot" || {
    echo "Error: Directory $HOME/apps/ds-bot does not exist."
    exit 1
  }
  tmux new-session -d -s ds-bot "node index.js" &
  echo "The ds-bot has been started."
fi

exit 0
