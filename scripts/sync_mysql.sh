#!/bin/bash
# auto sync master and slave of mysql 
# auther : <caolinxi_neu@163.com>
# date	 : 2018-08-05 15:17:00
######################################

DB_USER=root
DB_PASSWORD=root
SYNC_NAME=tongbu
SYNC_PASSWORD=123456
MASTER_NAME=mysql-master
SLAVE_NAME=mysql-slave1
MASTER_IP=192.168.10.2
SLAVE_IP=192.168.10.3



#if [ $# -eq 0 ];then
#	/usr/bin/echo -e "Please input DB_USER and DB_PASSWORD!"
#	/usr/bin/echo -e "\033[32mUsage:{/bin/bash $0 root root }\033[0m"
#	/usr/bin/exit 0
#fi

# =======container master===========
# grant replication slave
/usr/bin/docker exec $MASTER_NAME /bin/bash -c "mysql -u$DB_USER -h$MASTER_IP -p$DB_PASSWORD -e \"grant replication slave on *.* to '$SYNC_NAME'@'192.168.10.%' identified by '$SYNC_PASSWORD';\"" 

# get the name and the position of bin-log file
BIN_LOG_NAME=`/usr/bin/docker exec $MASTER_NAME /bin/bash -c "mysql -u$DB_USER -h$MASTER_IP -p$DB_PASSWORD -e \"show master status;\" " | /usr/bin/grep log-bin | /usr/bin/awk '{print $1}'` 
POSITION=`/usr/bin/docker exec $MASTER_NAME /bin/bash -c "mysql -u$DB_USER -h$MASTER_IP -p$DB_PASSWORD -e \"show master status;\" " | /usr/bin/grep log-bin | /usr/bin/awk '{print $2}'` 
/usr/bin/echo "bin-log  :$BIN_LOG_NAME"
/usr/bin/echo "position :$POSITION"

# =======container slave1============
/usr/bin/docker exec $SLAVE_NAME /bin/bash -c "mysql -u$DB_USER -h$SLAVE_IP -p$DB_PASSWORD -e \"stop slave;\""
/usr/bin/docker exec $SLAVE_NAME /bin/bash -c "mysql -u$DB_USER -h$SLAVE_IP -p$DB_PASSWORD -e \"CHANGE MASTER TO \
MASTER_HOST='$MASTER_NAME',\
MASTER_PORT=3306,\
MASTER_USER='$SYNC_NAME',\
MASTER_PASSWORD='$SYNC_PASSWORD',\
MASTER_LOG_FILE='$BIN_LOG_NAME',\
MASTER_LOG_POS=$POSITION;\"" 

/usr/bin/docker exec $SLAVE_NAME /bin/bash -c "mysql -u$DB_USER -h$SLAVE_IP -p$DB_PASSWORD -e \"start slave;\""  
/usr/bin/docker exec $SLAVE_NAME /bin/bash -c "mysql -u$DB_USER -h$SLAVE_IP -p$DB_PASSWORD -e \"show slave status\G;\"" | /usr/bin/grep Running: 

