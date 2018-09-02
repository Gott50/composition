#!/bin/sh

docker-machine create --driver virtualbox manager1

MANAGER_IP=$(docker-machine ip manager1)

docker-machine ssh manager1 "docker swarm init --advertise-addr $MANAGER_IP"
docker-machine scp docker-compose.yml manager1:
docker-machine scp -r .env/ manager1:
docker-machine ssh manager1 <<-'END_SSH'
    docker stack deploy --compose-file docker-compose.yml manager1
END_SSH
