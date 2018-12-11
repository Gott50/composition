#!/bin/bash

echo Composition Parameters: $@
INSTA_USER=$2

echo "Composition sudo docker stop /$INSTA_USER"
sudo docker stop /$INSTA_USER
echo "Composition sudo docker rm /$INSTA_USER"
sudo docker rm /$INSTA_USER

SETTINGS=${1//' '/''}

NODE=$(sudo docker info | grep "Node Address")
SELENIUM=${NODE/' Node Address: '/''}
# 18.196.202.48
# should be
# 18.197.130.112

CMD="sudo docker-compose run -d -e SELENIUM=selenium --name $INSTA_USER -e ENV=$SETTINGS -e INSTA_USER=$INSTA_USER -e INSTA_PW=$3 web"
echo Composition CMD: $CMD

$CMD