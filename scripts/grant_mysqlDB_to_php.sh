#!/bin/bash
# grant database to server of php
# author: <caolinxi_neu@163.com>
# date  : 2018-08-05 21:56:29
###################################

DB_USER=root
DB_PASSWORD=root
DB_USER_NAME=root
DB_USER_PASSWORD=123456
MYSQL_MASTER_NAME=mysql-master
PHP_IP=192.168.10.22


/usr/bin/docker exec $MYSQL_MASTER_NAME /bin/bash -c "mysql -u$DB_USER -h192.168.10.2 -p$DB_PASSWORD -e \"create database discuz charset=utf8;\""
/usr/bin/docker exec $MYSQL_MASTER_NAME /bin/bash -c "mysql -u$DB_USER -h192.168.10.2 -p$DB_PASSWORD -e \"grant all on discuz.* to $DB_USER_NAME@"$PHP_IP" identified by '$DB_USER_PASSWORD';\""
/usr/bin/docker exec $MYSQL_MASTER_NAME /bin/bash -c "mysql -u$DB_USER -h192.168.10.2 -p$DB_PASSWORD -e \"flush privileges;\""

