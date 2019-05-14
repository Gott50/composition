#!/bin/bash

scp -o StrictHostKeychecking=no -i bot.pem -r ec2-user@$1:/home/ec2-user bots/$1
