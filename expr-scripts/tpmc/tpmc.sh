#!/bin/bash
input=$1

python3 tpmc.py

gnuplot -persist <<-EOFMarker
    # setting
    set terminal png size 1024,768 font "Helvetica, 25"
    set output "$2.png"

    set title "Tpmc" font "Helvetica, 30"
    set style data histogram
    set style histogram rowstacked
    set xrange [-0.5:9.5]

    set style fill solid border -1
    set boxwidth 0.5 relative

    set xlabel "Redo Log size"
    set ylabel "TpmC"

    # plot
    plot "$1" using 2:xtic(1) notitle, \
                '' using 3 notitle;
EOFMarker

#How to use : py 파일에서 tpcc 파일 경로, 출력 타입 설정. 
#example command : ./tpmc.sh tpmc.txt output