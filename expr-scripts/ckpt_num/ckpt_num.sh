#!/bin/bash
input=$1

python3 ckpt_num.py

gnuplot -persist <<-EOFMarker
    # setting
    set term png size 1300,1000 font "Helvetica, 25"
    set output "$2.png"


<<<<<<< HEAD
    set title "The number of Checkpoint Trigger" font "Helvetica, 30"
=======
    set title "Checkpoint Trigger Ratio" font "Helvetica, 30"
>>>>>>> 810f6ec6fb5476aeff3d29dd13e23696a5ca51b2
    set style data histogram

    set style fill solid border -1

    set ylabel "Checkpoint 횟수"
<<<<<<< HEAD
    set xlabel "Redo Log size"
=======
    set xlabel "Redo log size"
>>>>>>> 810f6ec6fb5476aeff3d29dd13e23696a5ca51b2
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