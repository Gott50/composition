#!/bin/sh

P_USER=$1
shift

docker-machine create --driver $@
name=${@: -1}

# docker-machine regenerate-certs $name

MANAGER_IP=$(docker-machine ip $name)
eval "$(docker-machine env $name)"

CMD="ssh -i $DOCKER_CERT_PATH/id_rsa $P_USER@$MANAGER_IP echo ssh works!"
echo CMD=$CMD
$CMD

KNOWN_HOSTS=$(grep $MANAGER_IP ~/.ssh/known_hosts)
sed -i /$MANAGER_IP/d ~/.ssh/known_hosts

id_rsa=$(cat $DOCKER_CERT_PATH/id_rsa)
SSH_KEY=${id_rsa//
/_}

mkdir .env
echo "IP=$MANAGER_IP
SSH_KEY=$SSH_KEY
KNOWN_HOSTS=$KNOWN_HOSTS" > .env/.manager.env

echo ".manager.env: $(cat .env/.manager.env)"

docker-machine ssh $name "sudo docker swarm init --advertise-addr $MANAGER_IP"
docker-machine scp docker-prod.yml $name:
docker-machine scp -r .env/ $name:
docker-machine scp start_bot.sh $name:
docker-machine scp docker_clean.sh $name:
docker-machine ssh $name "sudo docker stack deploy --compose-file docker-prod.yml $name"
