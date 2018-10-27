#!/bin/sh

echo Parameters: $@

sudo docker stop /$1
sudo docker rm /$1

NODE=$(docker info | grep "Node Address")
SELENIUM=${NODE/' Node Address: '/''}

sudo docker run -d --name $1 -e SELENIUM=$SELENIUM -e ENV=$1 -e INSTA_USER=$2 -e INSTA_PW=$3 -e PROXY=$4 -v log_data:/code/logs instagramtools/web