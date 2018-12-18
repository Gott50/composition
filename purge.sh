#!/bin/sh

ZONE=$1
EMAIL=$2
KEY=$3

echo Purge with: $@

curl -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE/purge_cache" \
     -H "X-Auth-Email: $EMAIL" \
     -H "X-Auth-Key: $KEY" \
     -H "Content-Type: application/json" \
     --data '{"purge_everything":true}'