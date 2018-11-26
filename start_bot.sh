#!/bin/bash

echo Parameters: $@
INSTA_USER=$2

echo "sudo docker stop /$INSTA_USER"
sudo docker stop /$INSTA_USER
echo "sudo docker rm /$INSTA_USER"
sudo docker rm /$INSTA_USER

NODE=$(sudo docker info | grep "Node Address")
SELENIUM=${NODE/' Node Address: '/''}
# 18.196.202.48
# should be
# 18.197.130.112

CMD="sudo docker run -d --name $INSTA_USER -e SELENIUM=18.197.130.112 -e ENV=$1 -e INSTA_USER=$INSTA_USER -e INSTA_PW=$3 -e PROXY=$4 -v log_data:/code/logs instagramtools/web"
echo CMD: $CMD

$CMD