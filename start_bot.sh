#!/bin/sh

echo Parameters: $@

sudo docker stop /$1
sudo docker rm /$1

sudo docker run -d --name $1 -e INSTA_USER=$1 -e INSTA_PW=$2 \
-e ENV=$3 -v log_data:/code/logs instagramtools/web