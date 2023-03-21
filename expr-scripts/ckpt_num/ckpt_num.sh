#!/bin/bash
input=$1

python3 ckpt_num.py

gnuplot -persist <<-EOFMarker
    # setting
    set term png size 1300,1000 font "Helvetica, 25"
    set output "$2.png"


    set title "The number of Checkpoint Trigger" font "Helvetica, 30"
    set style data histogram

    set style fill solid border -1

    set ylabel "Checkpoint 횟수"
    set xlabel "Redo Log size"
    set boxwidth 1.0 relative

    # plot
    plot "$1" using 2:xtic(1) notitle, \
                '' using 3 title "Master", 				  \
                '' using 4 title "FlushList", 				    \
                '' using 5 title "Dirty", 				\
                '' using 6 title "Logging";
EOFMarker

#How to use : py 파일에서 tpcc 파일 경로, 출력 타입 설정. 
#example command : ./ckpt_num.sh ckpt_num.txt output