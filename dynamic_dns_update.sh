#!/bin/bash
API_KEY="$1"
DOMAIN="$2"
RECORD="$3"

if [ -z "$API_KEY" ] || [ -z "$DOMAIN" ] || [ -z "$RECORD" ]; then
  echo "Error: Please provide the API key, domain, and record as arguments."
  echo "Usage: ./dynamic_dns_update.sh <api_key> <domain> <record>"
  exit 1
fi

EXT_IP=$(curl -s ifconfig.me)


curl -X PUT \
     -H "Authorization: Apikey $API_KEY" \
     -H "Content-Type: application/json" \
     -d "{\"items\": [{\"rrset_type\": \"A\", \"rrset_ttl\": 10800, \"rrset_values\": [\"$EXT_IP\"]}]}" \
     "https://dns.api.gandi.net/api/v5/domains/$DOMAIN/records/$RECORD"