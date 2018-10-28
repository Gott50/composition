#!/bin/bash

echo Parameters: $@
INSTA_USER=$2

sudo docker stop /$INSTA_USER
sudo docker rm /$INSTA_USER

NODE=$(sudo docker info | grep "Node Address")
SELENIUM=${NODE/'Node Address: '/''}


sudo docker run -d --name $INSTA_USER -e SELENIUM=$SELENIUM -e ENV=$1 -e INSTA_USER=$INSTA_USER -e INSTA_PW=$3 -e PROXY=$4 -v log_data:/code/logs instagramtools/web