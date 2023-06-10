# Scripts

a repository of scripts that I use in some of my projects

## dynamic_dns_update.sh

I use [Gandi](https://www.gandi.net/) as my DNS provider and since I don't have a static IP address, it is possible that my IP will change and then my DNS routing wont work. Luckily Gandi has an API that one can use to update your DNS records. So I created a script that I run in my home server as a cron job every 30 minutes which will update the DNS record with my current IP address.

Usage:

```bash
./dynamic_dns_update.sh your_api_key domain record
```

## Dedicated server management

I have a home server that I use to host dedicated servers for a few steam games. It is quite a hassle to always login with the steamCMD, remember the app id etc. So I created scripts for installing/updating the games, running them on the background in a tmux session and closing them.

### update_steam_app.sh

Usage:

```bash
#as anonymous user
./update_steam_app.sh install_dir "" "" app_id

#as an existing user
./update_steam_app.sh install_dir username password app_id
```

### start_service.sh

Usage:

```bash
./start_service.sh service-name script_name
```

### stop_service.sh

Usage:

```bash
./stop_service.sh service-name
```
