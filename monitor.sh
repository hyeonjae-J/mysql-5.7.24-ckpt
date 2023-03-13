#!/bin/bash

echo $1

while :
do
    /home/vldb/mysql-5.7.24-ckpt/bld/bin/mysql -e "SHOW ENGINE INNODB STATUS\G;" >> $1
    sleep 60s
done