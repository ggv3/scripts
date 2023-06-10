#!/bin/bash

SERVICE_NAME="$1"

if [ -z "$SERVICE_NAME" ]; then
  echo "Error: Please provide the service name as an argument."
  echo "Usage: ./stop_service.sh <service_name>"
  exit 1
fi

if tmux has-session -t "$SERVICE_NAME" &>/dev/null; then
  # Send a SIGTERM signal to the process within the session
  tmux send-keys -t "$SERVICE_NAME" C-c

  # Wait for the process to exit gracefully
  sleep 2

  if tmux has-session -t "$SERVICE_NAME" &>/dev/null; then
    # Forcefully kill the session and all processes within it
    tmux kill-session -t "$SERVICE_NAME"
    echo "The $SERVICE_NAME has been forcefully terminated."
  else
    echo "The $SERVICE_NAME has been gracefully terminated."
  fi
else
  echo "The $SERVICE_NAME is not currently running."
fi