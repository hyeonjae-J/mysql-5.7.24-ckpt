#!/bin/bash

export LD_LIBRARY_PATH=/home/vldb/mysql-5.7.24-ckpt/bld/lib
config_file="/home/vldb/mysql-5.7.24-ckpt/my.cnf"
CKPT_DIR=/home/vldb/mysql-5.7.24-ckpt


for logbuf in 8M 16M 32M 64M 128M 256M 512M
do

# change my.cnf
sed -i 's/innodb_log_buffer_size=8M/innodb_log_buffer_size='${logbuf}'/' $config_file
sed -i 's/innodb_buffer_pool_size=5G/innodb_buffer_pool_size=20G/' $config_file

cat $config_file | grep 'innodb_buffer_pool_size'
cat $config_file | grep 'innodb_log_file_size'
cat $config_file | grep 'innodb_log_buffer_size'

output=/home/vldb/RESULT/logbuf_test2/20G_1G_${logbuf}_vanila

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
./tpcc_start -h127.0.0.1 -P3306 -dtpcc -uroot -w500 -r600 -c32 -l5400 | tee ${output}.tpcc  

# shutdown all process
pkill -15 -ef iostat
pkill -15 -ef vmstat
pkill -9 -ef monitor.sh
pkill -9 -ef mysqld

# restore config_file
sed -i 's/innodb_log_buffer_size='${logbuf}'/innodb_log_buffer_size=8M/' $config_file

sleep 300s

done