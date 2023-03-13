set terminal png size 1024,768 font "Helvetica, 25"
set output "tpmc_logbuf.png"

set title "Tpmc" font "Helvetica, 30"
set style data histogram
set style histogram rowstacked
set xrange [-0.5:5.5]

set style fill solid border -1
set boxwidth 0.5 relative

set xlabel "log buffer size"
set ylabel "tpmc"

# plot
plot "tpmc.txt" using 2:xtic(1) notitle, \
			 '' using 3 notitle 				  \