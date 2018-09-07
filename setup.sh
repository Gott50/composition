#!/bin/sh

docker-machine create --driver $@
name=${@: -1}
MANAGER_IP=$(docker-machine ip $name)
eval "$(docker-machine env $name)"

id_rsa=$(cat $DOCKER_CERT_PATH/id_rsa)
SSH_KEY=${id_rsa//
/**}

mkdir .env
echo "IP=$MANAGER_IP
SSH_KEY=$SSH_KEY" > .env/.manager.env

docker-machine ssh $name "sudo docker swarm init --advertise-addr $MANAGER_IP"
docker-machine scp docker-compose.yml $name:
docker-machine scp -r .env/ $name:
docker-machine ssh $name "sudo docker stack deploy --compose-file docker-compose.yml $name"
