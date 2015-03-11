#!/bin/bash
#
# script that creates a plot from all the ping-logs to the google DNS server
#

FOLDER=${LOGFOLDER}/*

for f in $FOLDER
do

awk 'NR%2' ${f} | awk '(NR+1)%2' | cut -f 2 -d"=" | cut -c 2- | sed '/^$/d' | cut -f 1 -d" " | tr "/" " ">${f}_temp.txt

gnuplot <<- EOF
	set title "${f}"
	unset xtics
	set xtics ("01" 7, "03" 19, "05" 31, "07" 43, "09" 55, "11" 67, "13" 79, "15" 91, "17" 103, "19" 115, "21" 127, "23" 139)
        set xlabel "time"
	set ylabel "ping time in ms"
	set yrange[0:300]
        set term png
        set output "${f}.png"
        plot "${f}_temp.txt" using 0:1 with lines title "min", "${f}_temp.txt" using 0:2 with lines title "avg", "${f}_temp.txt" using 0:3 with lines title "max"
EOF


rm ${f}_temp.txt

done
