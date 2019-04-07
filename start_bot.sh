#!/bin/bash


sudo docker rm /selenium
sudo docker run -d --net=bridge --name selenium selenium/standalone-chrome:3.141.59

echo Composition Parameters: $@
INSTA_USER=$2

echo "Composition sudo docker stop /$INSTA_USER"
sudo docker stop /$INSTA_USER
echo "Composition sudo docker rm /$INSTA_USER"
sudo docker rm /$INSTA_USER

SETTINGS=${1//' '/''}

NODE=$(sudo docker info | grep "Node Address")

CMD="sudo docker run -d -net=bridge --link selenium:selenium -e SELENIUM=selenium --name $INSTA_USER -e ENV=$SETTINGS -e INSTA_USER=$INSTA_USER -e INSTA_PW=$3 web"
echo Composition CMD: $CMD

$CMD