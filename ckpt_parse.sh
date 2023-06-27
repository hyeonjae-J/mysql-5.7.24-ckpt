#!/bin/bash

#1. tpmc, tps, checkpoint된 총 페이지 개수
#2. 평균 r/s, w/s, rkB/s, wkB/s
#3. 평균 device util 100%인지 (i/o bound check)
#4. 평균 cpu util
#5. transaction 당 read/write iops == 평균 (r/s) / tps, 평균 (w/s) / tps  


data_dir="/home/vldb/test_data"
log_dir="/home/vldb/test_log/"
backup_dir="/home/vldb/BACKUP"
result_dir="$1"

mysql_dir="/home/vldb/mysql-5.7.24-ckpt"
tpcc_dir="/home/vldb/tpcc-mysql"

device="sdb"

cd ${result_dir}
echo "########################################" >> ${result_dir}/result.txt

#1. TPS, TpmC
cat trx.log | grep "trx" | awk '{ print $3 } '| tr -d , | awk '{ sum+=$1} END {print "TPS: " sum/5400; print "TpmC: " sum/90}' >> ${result_dir}/result.txt


#2. 평균 r/s, w/s, rkB/s, wkB/s
cat iostat.out | grep $device | awk '{ sum+=$2} END {print "read/s: " sum/5400;}' >> ${result_dir}/result.txt
cat iostat.out | grep $device | awk '{ sum+=$3} END {print "write/s: " sum/5400;}' >> ${result_dir}/result.txt
cat iostat.out | grep $device | awk '{ sum+=$4} END {print "rMB/s: " sum/5400/1000;}' >> ${result_dir}/result.txt
cat iostat.out | grep $device | awk '{ sum+=$5} END {print "wMB/s: " sum/5400/1000;}' >> ${result_dir}/result.txt

#3. CPU util
cat iostat.out | grep -A 1 "idle" | awk '{ sum+=$6} END {print "CPU util(%): " 100-sum/5400;}' >> ${result_dir}/result.txt

#4. Device util
cat iostat.out | grep $device |  awk '{ sum+=$16} END {print "Device util(%): " sum/5400;}' >> ${result_dir}/result.txt

cd ${log_dir}


# #default 일 때.
# #체크포인트 횟수와, 체크포인트된 페이지의 총 갯수.
# echo "Checkpoint num : $(grep -c "buf_do_flush_batch cycle done" mysql_error_nvdimm.log)" >> ${result_dir}/result.txt && echo "Checkpointed page num : $(grep -c "bpage old boolean :" mysql_error_nvdimm.log)" >> ${result_dir}/result.txt
# #체크포인트 횟수 별 페이지 수.
# cat mysql_error_nvdimm.log | grep "bpage space : " | awk '{bpage_info = $8 " " $12; count[bpage_info]++} END {print "Total page num:", length(count); for (info in count) {if (count[info] == 1) once++; else if (count[info] == 2) twice++; else if (count[info] == 3) thrice++; else if (count[info] == 4) four++; else if (count[info] == 5) five++; else if (count[info] == 6) six++; else if (count[info] == 7) seven++; else if (count[info] == 8) eight++; else if (count[info] == 9) nine++; else if (count[info] == 10) ten++; else more_than_ten++} print "Once:", once; print "Twice:", twice; print "Thrice:", thrice; print "Four:", four; print "Five:", five; print "Six:", six; print "Seven:", seven; print "Eight:", eight; print "Nine:", nine; print "Ten:", ten; print "More than ten:", more_than_ten}' >> ${result_dir}/result.txt

#ckpt flag 사용할 때
#체크포인트 횟수, 체크포인트된 페이지의 총 갯수, Skipped page 총 갯수.
cat mysql_error_nvdimm.log | awk '/Skipped bpage'\''s space/ {skip++} /Checkpointed bpage'\''s space/ {checknum++} /buf_do_flush_batch cycle done/ {batch++} END {print "Skipped page num: " skip "\nCheckpointed page num: " checknum "\nCheckpoint num: " batch}' >> ${result_dir}/result.txt
# #체크포인트 횟수 별 페이지 수.
cat mysql_error_nvdimm.log | grep "bpage's space" | awk '{bpage_info = $15 " " $16; page_count[bpage_info]++} END {print "Total page num:", length(page_count); for (info in page_count) {if (page_count[info] == 1) once++; else if (page_count[info] == 2) twice++; else if (page_count[info] == 3) thrice++; else if (page_count[info] == 4) four++; else if (page_count[info] == 5) five++; else if (page_count[info] == 6) six++; else if (page_count[info] == 7) seven++; else if (page_count[info] == 8) eight++; else if (page_count[info] == 9) nine++; else if (page_count[info] == 10) ten++; else more_than_ten++} print "Once:", once; print "Twice:", twice; print "Thrice:", thrice; print "Four:", four; print "Five:", five; print "Six:", six; print "Seven:", seven; print "Eight:", eight; print "Nine:", nine; print "Ten:", ten; print "More than ten:", more_than_ten}' >> ${result_dir}/result.txt



echo "########################################" >> ${result_dir}/result.txt
