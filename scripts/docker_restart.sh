#!/bin/bash

# Restart all running containers
sudo docker stop $(sudo docker ps -q)