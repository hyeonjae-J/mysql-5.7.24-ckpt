#!/bin/bash

export LD_LIBRARY_PATH=/home/vldb/mysql-5.7.24-ckpt/bld/lib

config_file="/home/vldb/mysql-5.7.24-ckpt/my.cnf"
CKPT_DIR=/home/vldb/mysql-5.7.24-ckpt
RESULT_DIR=/home/vldb/RESULT/redo_test3

mkdir ${RESULT_DIR}

for redolog in 1G 2G 3G 4G 5G 6G 7G 8G 9G 10G
do

# change my.cnf
sed -i 's/innodb_log_file_size=1G/innodb_log_file_size='${redolog}'/' $config_file
#sed -i 's/innodb_buffer_pool_size=5G/innodb_buffer_pool_size=20G/' $config_file

cat $config_file | grep 'innodb_buffer_pool_size'
cat $config_file | grep 'innodb_log_file_size'
cat $config_file | grep 'innodb_log_buffer_size'


output=${RESULT_DIR}/20G_${redolog}_16M_vanila

cd ${CKPT_DIR}
./START.sh
sleep 300s

iostat -x 1 | awk '/avg-cpu/{print;getline;print;getline;print}/Device/{print}/sdb/{print}' &> ${output}.iostat &
vmstat 1 &> ${output}.vmstat &

# run monitoring 
./monitor.sh $output.stat &

# run tpc-c
cd /home/vldb/tpcc-mysql
./tpcc_start -h127.0.0.1 -P3306 -dtpcc -uroot -w500 -r600 -c32 -l5400 | tee ${output}.tpcc  

# shutdown all process
pkill -15 -ef iostat
pkill -15 -ef vmstat
pkill -9 -ef monitor.sh
pkill -9 -ef mysqld

# restore config_file
sed -i 's/innodb_log_file_size='${redolog}'/innodb_log_file_size=1G/' $config_file

sleep 300s

done