#!/bin/bash

# ckpt ratio에 따른 tpmc 변화 실험을 위한 실행파일.

config_file="/home/vldb/mysql-5.7.24-ckpt/storage/innobase/buf/buf0flu.cc"
CKPT_DIR=/home/vldb/mysql-5.7.24-ckpt
RESULT_DIR=/home/vldb/RESULT/recovery3
mkdir ${RESULT_DIR}

for ratio in 1 0.7 0.5 0.3 0.1
do

output=${RESULT_DIR}/${ratio}

# remove bld dir
echo "vldb#1234" | sudo -S rm -rf bld

# change return ckpt_ratio in buf0flu.cc
sed -i 's/return(n_pages);/return(n_pages*'${ratio}');/' $config_file
# check ckpt_ratio
cat $config_file | grep 'return(n_pages'

# build again
./build.sh --f2ckpt

# Restore backup data and Start Server 
./START.sh
sleep 300s

# run tpc-c
cd /home/vldb/tpcc-mysql
(./tpcc_start -h 127.0.0.1 -S /tmp/mysql.sock -d tpcc -uroot -w 500 -c 32 -r 300 -l 5400 | tee ${output}.tpcc) &

# Wait 20 minutes and then terminate tpcc_start
sleep 1200s

# shutdown server
pkill -9 -ef mysqld
pkill -15 -ef tpcc_start

# restore config_file
sed -i 's/return(n_pages\*'${ratio}');/return(n_pages);/' $config_file

sleep 30s

# move to ckpt dir again
cd ${CKPT_DIR}

# MySQL Server restart
echo "vldb#1234" | sudo -S rm -rf /home/vldb/test_log/mysql_error_nvdimm.log
./bld/bin/mysqld --defaults-file=./my.cnf --disable-log-bin &>/dev/null &disown

echo "Server On Again"
sleep 300s

# logging for checking recovery time
cat /home/vldb/test_log/mysql_error_nvdimm.log > ${output}.log

# shutdown mysql server again
pkill -9 -ef mysqld

sleep 60s

done