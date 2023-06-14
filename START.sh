#!/bin/bash

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
