#!/bin/bash

result=$(ps -ef | grep ./bld/bin/mysqld  | awk 'NR == 1 { print $2;}')
sudo gdb -p $result