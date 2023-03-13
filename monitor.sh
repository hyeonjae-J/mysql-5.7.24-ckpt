#!/bin/bash

echo $1

while :
do
    /home/vldb/F2-CKPT/bld/bin/mysql -e "SHOW ENGINE INNODB STATUS\G;" >> $1
    sleep 60s
done