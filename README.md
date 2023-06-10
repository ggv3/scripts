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
