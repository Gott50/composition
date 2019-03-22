#!/bin/sh
name=${@: -1}
DATE=`date '+%Y-%m-%d'`
docker-machine scp -r $name:backup/pg_dump_$DATE.tar backup/
