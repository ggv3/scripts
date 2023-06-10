# Scripts

a repository of scripts that I use in some of my projects

## dynamic_dns_update.sh

I use [Gandi](https://www.gandi.net/) as my DNS provider and since I don't have a static IP address, it is possible that my it will change and now my DNS routing wont work. Luckily Gandi has an API that one can use to update your DNS records. So I created a script that I run in my home server as a cron job every 30 minutes which will update the DNS record with my current IP address.

```bash
#!/bin/bash
API_KEY="API_KEY"
DOMAIN="DOMAIN"
EXT_IP=$(curl -s ifconfig.me)
RECORD="RECORD"

curl -X PUT \
     -H "Authorization: Apikey $API_KEY" \
     -H "Content-Type: application/json" \
     -d "{\"items\": [{\"rrset_type\": \"A\", \"rrset_ttl\": 10800, \"rrset_values\": [\"$EXT_IP\"]}]}" \
     "https://dns.api.gandi.net/api/v5/domains/$DOMAIN/records/$RECORD"
```

## Dedicated server management

I have a home server that I use to host dedicated servers for a few steam games. It is quite a hassle to always login with the steamCMD, remember the app id etc. So I created scripts for installing/updating the games, running them on the background in a tmux session and closing them.

### update_steam_app.sh

```bash
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
```

Usage:

```bash
#as anonymous user
./update_steam_app.sh install_dir "" "" app_id

#as an existing user
./update_steam_app.sh install_dir username password app_id
```
