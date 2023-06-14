#!/bin/bash

export LD_LIBRARY_PATH=/home/vldb/mysql-5.7.24-ckpt/bld/lib
config_file="/home/vldb/mysql-5.7.24-ckpt/my.cnf"
CKPT_DIR=/home/vldb/mysql-5.7.24-ckpt
RESULT_DIR=/home/vldb/RESULT/20G_10G_16M

mkdir ${RESULT_DIR}

for buf in 20
do

# change my.cnf
sed -i 's/innodb_buffer_pool_size=20G/innodb_buffer_pool_size='${buf}G'/' $config_file

cat $config_file | grep 'innodb_buffer_pool_size'
cat $config_file | grep 'innodb_log_file_size'
cat $config_file | grep 'innodb_log_buffer_size'

output=${RESULT_DIR}/${buf}G

cd ${CKPT_DIR}
./START.sh
sleep 300s

iostat -x 1 | awk '/avg-cpu/{print;getline;print;getline;print}/Device/{print}/sdb/{print}' &> ${output}.iostat &

vmstat 1 &> ${output}.vmstat &

# run monitoring 
cd /home/vldb/mysql-5.7.24-ckpt
./monitor.sh $output.stat &

# run tpc-c
cd /home/vldb/tpcc-mysql
./tpcc_start -h127.0.0.1 -P3306 -dtpcc -uroot -w500 -r10 -c32 -l600 | tee ${output}.tpcc  

# shutdown all process
pkill -15 -ef iostat
pkill -15 -ef vmstat
pkill -9 -ef monitor.sh
pkill -9 -ef mysqld

# restore config_file
sed -i 's/innodb_buffer_pool_size='${buf}'G/innodb_buffer_pool_size=20G/' $config_file
sleep 300s

done