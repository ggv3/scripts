#!/bin/bash

INSTALL_DIR="$1"
LOGIN_USERNAME="$2"
LOGIN_PASSWORD="$3"
APP_ID="$4"

if [ -z "$INSTALL_DIR" ] || [ -z "$APP_ID" ]; then
  echo "Error: Please provide the install directory and app ID as arguments."
  echo "Usage: ./update_steam_app.sh <install_dir> [<login_username> <login_password>] <app_id>"
  exit 1
fi

if ! command -v steamcmd &> /dev/null; then
    echo "Error: SteamCMD is not installed."
    exit 1
fi

steamcmd_command="steamcmd +force_install_dir $INSTALL_DIR"

if [ -n "$LOGIN_USERNAME" ]; then
  if [ -n "$LOGIN_PASSWORD" ]; then
    steamcmd_command+=" +login $LOGIN_USERNAME $LOGIN_PASSWORD"
  else
    steamcmd_command+=" +login $LOGIN_USERNAME"
  fi
else
  steamcmd_command+=" +login anonymous"
fi

steamcmd_command+=" +app_update $APP_ID validate +quit"

eval "$steamcmd_command"