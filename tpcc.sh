#!/bin/bash

#tpcc한번 돌릴때, data초기화, server 키기, logging, tpcc 실행해줌.

# loading data
echo "Remove MySQL data start"
rm -rf /mnt/pmemdir/nvdimm_mmap_file
rm -rf /home/vldb/test_data/*
rm -rf /home/vldb/test_log/*
echo "Remove MySQL data finish"

echo "Loading MySQL data start"
cp -rp /home/vldb/BACKUP/* /home/vldb/test_data/
echo "Loading MySQL data finish"


#MySQL Server start
./bld/bin/mysqld --defaults-file=./my.cnf --disable-log-bin &>/dev/null &disown

echo "Server On"
sleep 180s

###############Should be filled#################
export LD_LIBRARY_PATH=/home/vldb/mysql-5.7.24-ckpt/bld/lib
RESULT_DIR=/home/vldb/RESULT/default_25G_1_buf
mkdir ${RESULT_DIR}

#logging
iostat -x 1 | awk '/avg-cpu/{print;getline;print;getline;print}/Device/{print}/sdb/{print}' &> ${RESULT_DIR}/iostat.out &
vmstat 1 &> ${RESULT_DIR}/vmstat.out &
#SHOW ENGINE INNODB STATUS by 1 sec
./monitor.sh ${RESULT_DIR}/stat.out &


# run tpc-c
cd /home/vldb/tpcc-mysql
./tpcc_start -h 127.0.0.1 -S /tmp/mysql.sock -d tpcc -uroot -w 500 -c 8 -r 0 -l 5400 | tee ${RESULT_DIR}/trx.log


# shutdown all process
pkill -15 -ef iostat
pkill -15 -ef vmstat
pkill -9 -ef monitor.sh
pkill -9 -ef mysqld

cd /home/vldb/mysql-5.7.24-ckpt
./ckpt_parse.sh ${RESULT_DIR}

echo "Parsing finish"