#!/bin/bash

SERVICE_NAME="$1"
shift
SCRIPT_NAME="$@"

if [ -z "$SERVICE_NAME" ] || [ -z "$SCRIPT_NAME" ]; then
  echo "Error: Please provide the service name and the script to run as arguments."
  echo "Usage: ./start_service.sh <service_name> <script_name>"
  exit 1
fi

if ! command -v tmux &>/dev/null; then
  echo "Error: tmux is not installed. Please install tmux to continue."
  exit 1
fi

if tmux has-session -t "$SERVICE_NAME" &>/dev/null; then
  echo "The $SERVICE_NAME is already running."
else
  cd "$HOME/games/$SERVICE_NAME" || {
    echo "Error: Directory $HOME/games/$SERVICE_NAME does not exist."
    exit 1
  }
  tmux new-session -d -s "$SERVICE_NAME" "./$SCRIPT_NAME" &
  echo "The $SERVICE_NAME has been started."
fi

exit 0
