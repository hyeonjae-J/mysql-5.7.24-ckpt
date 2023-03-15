#!/bin/bash
input=$1

python3 line.py

gnuplot -persist <<-EOFMarker
    # setting
    set term png size 750,500
    set output "$2.png"
    set xlabel "Time (per 10s)" offset 1.5
    set ylabel "Transactions per 10 seconds"
    set pointsize 1
    set xrange [0:540]
    set yrange [0:20000]
    # plot101
    plot "$1" index 0 with lines title "20G, 1G, 16M", \
        "$1" index 1 with lines title "20G, 2G, 16M", \
        "$1" index 2 with lines title "20G, 3G, 16M", \
        "$1" index 3 with lines title "20G, 4G, 16M", \
        "$1" index 4 with lines title "20G, 5G, 16M", \
        "$1" index 5 with lines title "20G, 6G, 16M", \
        "$1" index 6 with lines title "20G, 7G, 16M", \
        "$1" index 7 with lines title "20G, 8G, 16M", \
        "$1" index 8 with lines title "20G, 9G, 16M", \
        "$1" index 9 with lines title "20G, 10G, 16M";
EOFMarker

#How to use : py 파일에서 tpcc 파일 경로 설정.
#example command : ./line.sh line.txt output