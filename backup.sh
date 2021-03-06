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

id_rsa=$(cat ./bot.pem)
SSH_KEY=${id_rsa//
/_}

mkdir .env
echo "MANAGER_IP=$MANAGER_IP
SSH_KEY=$SSH_KEY" > .env/.manager.env

echo ".manager.env: $(cat .env/.manager.env)"


docker-machine ssh $name "mkdir backup"
docker-machine scp dcp.sh $name:~/backup/
docker-machine ssh $name <<-'ENDBACKUP'
    DATE=`date '+%Y-%m-%d'`
    CONTAINER=$(sudo docker ps -f NAME=postgres --format 'table {{.ID}}' | grep -v -w CONTAINER)
    cd backup
    find . -type f -name '*.tar' -print0 | xargs -0 rm --
    sudo docker exec $CONTAINER pg_dump --dbname=postgres --schema=public --format=t --file=/tmp/pg_dump_$DATE.tar --username=postgres
    sudo ./dcp.sh $CONTAINER:/tmp/pg_dump_$DATE.tar .
    sudo chmod 777 pg_dump_$DATE.tar
ENDBACKUP

DATE=`date '+%Y-%m-%d'`
docker-machine scp -r $name:backup/pg_dump_$DATE.tar backup/
