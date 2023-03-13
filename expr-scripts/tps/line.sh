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
    set yrange [0:30000]
    # plot
    plot "$1" index 0 with lines title "20G, 1G, 128M, 10%", \
        "$1" index 1 with lines title "20G, 1G, 128M, 100%(vanila)", \
        "$1" index 2 with lines title "20G, 1G, 128M, 100%(vanila2)"; 
EOFMarker


#example command : sh line.sh line.txt output