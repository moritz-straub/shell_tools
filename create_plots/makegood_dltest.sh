#!/bin/bash

FOLDER=${LOGFOLDER}/*2014-12*_100M.txt

liste="\"dummy.txt\" using 0:1 with lines"

for f in $FOLDER
do
echo ${f}
awk 'NR%2' ${f} | cut -f 2 -d"(" | cut -f 1 -d ")">${f}_temp.txt

	${STARTFOLDER}/tools/mb_to_kb.sh ${f}_temp.txt
	

	gnuplot <<- EOF
		set title "${f}"
		unset xtics
		set xtics ("02" 13, "04" 25, "06" 37, "08" 49, "10" 61, "12" 73, "14" 85, "16" 97, "18" 109, "20" 121, "22" 133, "24" 143)
			set xlabel "time"
		set ylabel "download speed in KB/s"
		set yrange[0:9000]
			set term png
			set output "${f}.png"
			plot "${f}_temp.txt_KB.txt" using 0:1 with lines title "download speed"
	EOF

rm ${f}_temp.txt
rm ${f}_temp.txt_KB.txt

done
