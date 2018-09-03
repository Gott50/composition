#!/bin/sh

docker-machine create --driver virtualbox manager1

MANAGER_IP=$(docker-machine ip manager1)
eval "$(docker-machine env manager1)"

id_rsa=$(cat $DOCKER_CERT_PATH/id_rsa)
SSH_KEY=${id_rsa//
/**}

mkdir .env
echo "IP=$MANAGER_IP
SSH_KEY=$SSH_KEY" > .env/.manager.env

docker-machine ssh manager1 "docker swarm init --advertise-addr $MANAGER_IP"
docker-machine scp docker-compose.yml manager1:
docker-machine scp -r .env/ manager1:
docker-machine ssh manager1 <<-'END_SSH'
    docker stack deploy --compose-file docker-compose.yml manager1
END_SSH
