#!/bin/bash
# auto unzip Discuz.tar.gz and chmod discuz files
# auther : <caolinxi_neu@163.com>
# date   : 2018-08-06 10:25:06
#################################################

REDIS_MASTER=192.168.10.12
#cd ../php
PATH=$PWD/php
#/usr/bin/echo $PATH

if [ -d $PATH/discuz ];then
	/usr/bin/rm -rf $PATH/discuz
	/usr/bin/echo -e "remove the discuz directory forcefully..."
fi

/usr/bin/unzip -oq $PATH/Discuz_X3.3_SC_UTF8.zip -d $PATH/discuz/
/usr/bin/mv $PATH/discuz/upload/* $PATH/discuz
/usr/bin/chmod o+w $PATH/discuz/config/ $PATH/discuz/data/ $PATH/discuz/uc_*/ -R

