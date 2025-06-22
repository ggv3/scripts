#!/bin/bash

if tmux has-session -t ds-bot &>/dev/null; then
  # Send a SIGTERM signal to the process within the session
  tmux send-keys -t ds-bot C-c

  # Wait for the process to exit gracefully
  sleep 2

  if tmux has-session -t ds-bot &>/dev/null; then
    # Forcefully kill the session and all processes within it
    tmux kill-session -t ds-bot
    echo "The ds-bot has been forcefully terminated."
  else
    echo "The ds-bot has been gracefully terminated."
  fi
else
  echo "The ds-bot is not currently running."
fi