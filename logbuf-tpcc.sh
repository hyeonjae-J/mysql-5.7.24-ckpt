#!/bin/bash

export LD_LIBRARY_PATH=/home/vldb/F2-CKPT/bld/lib
config_file="/home/vldb/F2-CKPT/my.cnf"
CKPT_DIR=/home/vldb/F2-CKPT


for logbuf in 8M 16M 32M 64M 128M 256M 512M
do

# change my.cnf
echo "vldb#1234" | sudo -S sed -i 's/innodb_log_buffer_size=8M/innodb_log_buffer_size='${logbuf}'/' $config_file
echo "vldb#1234" | sudo -S sed -i 's/innodb_buffer_pool_size=5G/innodb_buffer_pool_size=20G/' $config_file

cat $config_file | grep 'innodb_buffer_pool_size'
cat $config_file | grep 'innodb_log_file_size'
cat $config_file | grep 'innodb_log_buffer_size'

output=/home/vldb/RESULT/logbuf_test2/20G_1G_${logbuf}_vanila

cd ${CKPT_DIR}
echo "vldb#1234" | sudo -S ./START.sh
sleep 300s

iostat -x 1 | grep -A1 idle &> ${output}.iostat &
iostat -mx -d 1 | grep sdb &> ${output}.iostat &
vmstat 1 &> ${output}.vmstat &

# run monitoring 
cd /home/vldb/F2-CKPT
./monitor.sh $output.stat &

# run tpc-c
cd /home/vldb/tpcc-mysql
sudo ./tpcc_start -h127.0.0.1 -P3306 -dtpcc -uroot -w500 -r600 -c32 -l5400 | tee ${output}.tpcc  

# shutdown all process
sudo pkill -15 -ef iostat
sudo pkill -15 -ef vmstat
sudo pkill -9 -ef monitor.sh
sudo pkill -9 -ef mysqld

# restore config_file
echo "vldb#1234" | sudo -S sed -i 's/innodb_log_buffer_size='${logbuf}'/innodb_log_buffer_size=8M/' $config_file

sleep 300s

done