#!/bin/sh

sh backup.sh $@

name=${@: -1}
MANAGER_IP=$(docker-machine ip $name)


docker-machine scp docker-prod.yml $name:
docker-machine scp -r .env/ $name:
docker-machine scp -r scripts/ $name:

docker-machine ssh $name "sudo docker swarm init --advertise-addr $MANAGER_IP"
docker-machine ssh $name "sudo docker stack deploy --compose-file docker-prod.yml $name"
docker-machine ssh $name "sudo sh scripts/docker_clean.sh"