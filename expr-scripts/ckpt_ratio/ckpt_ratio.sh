#!/bin/bash
input=$1

python3 ckpt_ratio.py

gnuplot -persist <<-EOFMarker
    # setting
    set term png size 1920,1080 font "Helvetica, 25"
    set output "$2.png"


    set title "Checkpoint Trigger Ratio" font "Helvetica, 30"
    set yrange [0:100]
    set style data histogram

    set style histogram rowstacked
    set style fill solid border -1
    set key outside right center vertical reverse Left 

    set ylabel "Ratio (%)" offset 1.5
    set xlabel "log buffer size"
    set boxwidth 0.55 relative

    # plot
    plot "$1" using 2:xtic(1) notitle, \
                '' using 3 title "Master", 				  \
                '' using 4 title "FlushList", 				    \
                '' using 5 title "Dirty", 				\
                '' using 6 title "Logging";
EOFMarker

#How to use : py 파일에서 tpcc 파일 경로, 출력 타입 설정. 
#example command : ./ckpt_ratio.sh ckpt_ratio.txt output