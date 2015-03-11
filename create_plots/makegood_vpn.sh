#!/bin/bash
#
# script that creates a plot from all the ping-logs between the hosts via VPN
#


FOLDER=${LOGFOLDER}/*.txt

for f in $FOLDER
do
echo ${f}

gnuplot <<- EOF
		set notitle
		set xlabel "Date"
		set xdata time
		set timefmt "%Y-%m-%d"
		set format x "%d.%m."
		set key above
		set xrange["2014-12-01":"2014-12-31"]
		set ylabel "Ping in ms"
		set yrange[0:300]
		set arrow 1 from "2014-12-23",0 to "2014-12-23",300 nohead
		set arrow 2 from "2014-12-27",0 to "2014-12-27",300 nohead
		set style line 1 lt rgb "blue" lw 1 pt 7 ps .4
		set style line 2 lt rgb "green" lw 1 pt 7 ps .4
		set style line 3 lt rgb "red" lw 1 pt 7 ps .4
		
		set term eps
			set output "${f}.eps"
			plot "${f}" using 1:2 with linespoints ls 1 title "min", "${f}" using 1:3 with linespoints ls 2 title "avg", "${f}" using 1:4 with linespoints ls 3 title "max"
	EOF

done
