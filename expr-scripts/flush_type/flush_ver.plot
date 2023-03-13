set term pdf size 20,10 font "Helvetica, 35"
set output "flush_ver_64.pdf"

#set title "Flush Type Ratio" font "Helvetica, 45"
set title " " font "Helvetica, 45"

set yrange [0:100]
set xrange [-0.5:7.5]

set style data histogram
set style histogram rowstacked
set style fill solid border -0.3
set key outside right center vertical reverse Left 

set xlabel "[ Log buffer : 64M ]" font "Helvetica, 40" offset 32, 27
set ylabel "Ratio (%)"
set boxwidth 0.5 relative

# plot
plot "flush_ver.txt" using 2:xtic(1) notitle, \
             '' using 3 title "CKPT Writes", 				  \
			 '' using 4 title "LRU Writes", 				    \
			 '' using 5 title "SPF Writes"		    \