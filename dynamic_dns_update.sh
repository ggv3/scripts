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