#!/bin/bash
apt install jq

# remove exited containers:
docker ps --filter status=dead --filter status=exited -aq | xargs -r docker rm -v

# remove unused images:
docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs -r docker rmi

# remove unused volumes (needs to be ran as root):
sudo docker volume ls -qf dangling=true | sudo xargs -r docker volume rm