set term png size 1920,1080 font "Helvetica, 25"
set output "ckpt_trigger_logbuf.png"

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
plot "ckpt-trigger.txt" using 2:xtic(1) notitle, \
			 '' using 3 title "Master", 				  \
			 '' using 4 title "Dirty", 				    \
			 '' using 5 title "FlushList", 				\
			 '' using 6 title "Logging", 			    \
          \