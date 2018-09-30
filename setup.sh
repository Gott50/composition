#!/bin/sh

docker-machine create --driver $@
name=${@: -1}
MANAGER_IP=$(docker-machine ip $name)
eval "$(docker-machine env $name)"

ssh -i $DOCKER_CERT_PATH/id_rsa docker@$MANAGER_IP echo "ssh works!"
sed -i '/$MANAGER_IP/d' ~/.ssh/known_hosts

id_rsa=$(cat $DOCKER_CERT_PATH/id_rsa)
SSH_KEY=${id_rsa//
/_}

mkdir .env
echo "IP=$MANAGER_IP
SSH_KEY=$SSH_KEY
KNOWN_HOSTS=$(grep $MANAGER_IP ~/.ssh/known_hosts)" > .env/.manager.env

docker-machine ssh $name "sudo docker swarm init --advertise-addr $MANAGER_IP"
docker-machine scp docker-compose.yml $name:
docker-machine scp -r .env/ $name:
docker-machine scp start_bot.sh $name:
docker-machine ssh $name "sudo docker stack deploy --compose-file docker-compose.yml $name"
