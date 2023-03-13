#!/bin/bash

# loading data
echo "Remove MySQL data start"
rm -rf /mnt/pmemdir/nvdimm_mmap_file
rm -rf /home/vldb/test_data/*
rm -rf /home/vldb/test_log/*
echo "Remove MySQL data finish"

# tpcc 10 wh

#cp -r /home/vldb/BACKUP/mysql-10/* /home/vldb/test_data/
# tpcc 500 wh

echo "Loading MySQL data start"
cp -rp /home/vldb/BACKUP/* /home/vldb/test_data/
#cp -r /home/vldb/BACKUP/new-mysql-500/* /home/vldb/test_data/
# tpcc 1000 wh
#cp -r /home/vldb/BACKUP/mysql-1000/* /home/vldb/test_data/

echo "Loading MySQL data finish"

#echo 'my.cnf (nvdimm) working!'
#gdb --args ./mysqld --defaults-file=../../my.cnf --disable-log-bin #&>/dev/null &disown
/home/vldb/mysql-5.7.24-ckpt/bld/bin/mysqld --defaults-file=/home/vldb/mysql-5.7.24-ckpt/my.cnf --disable-log-bin &>/dev/null &disown
echo "Server On"
