#!/bin/bash
#
# auto config all container
################################################################


# If docker containers are running, stop all containers firstly.
FLAG=`docker network ls | grep -o web_net`
if [[ "web_net" ==  $FLAG ]];then
	docker-compose down
fi

scripts/auto_unzip_and_chmod_Discuz.sh
/usr/bin/docker-compose up -d

/usr/bin/sleep 1 

#scripts/sync_mysql.sh 
#scripts/grant_mysqlDB_to_php.sh
