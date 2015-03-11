#!/bin/bash
#
# script that creates a plot from all the download-speed-logs highlighting the Christmas days
#

FOLDER=${LOGFOLDER}/*2014-12*_100M.txt

liste="\"dummy.txt\" using 0:1 with lines"

for f in $FOLDER
do
echo ${f}
awk 'NR%2' ${f} | cut -f 2 -d"(" | cut -f 1 -d ")">${f}_temp.txt

	${STARTFOLDER}/tools/mb_to_kb.sh ${f}_temp.txt
	

	

rm ${f}_temp.txt
#rm ${f}_temp.txt_KB.txt

if [[ "${f}" =~ "12-23" ]]; then
	liste=$liste", \"${f}_temp.txt_KB.txt\" using 0:1 with lines lc rgb '#00FF00' linewidth 2 title '23.12.'" 
elif [[ "${f}" =~ "12-24" ]]; then
	liste=$liste", \"${f}_temp.txt_KB.txt\" using 0:1 with lines lc rgb '#a2142f' linewidth 2 title '24.12.'"
elif [[ "${f}" =~ "12-25" ]]; then
	liste=$liste", \"${f}_temp.txt_KB.txt\" using 0:1 with lines lc rgb '#FF8C00' linewidth 2 title '25.12.'"
elif [[ "${f}" =~ "12-26" ]]; then
	liste=$liste", \"${f}_temp.txt_KB.txt\" using 0:1 with lines lc rgb '#4B0082' linewidth 2 title '26.12.'"
elif [[ "${f}" =~ "12-27" ]]; then
	liste=$liste", \"${f}_temp.txt_KB.txt\" using 0:1 with lines lc rgb '#00CED1' linewidth 2 title '27.12.'"
else
	liste=$liste", \"${f}_temp.txt_KB.txt\" using 0:1 with lines lc rgb '#696969' linewidth 1 notitle" 
fi

 
done

echo $liste

#set title depending on source

gnuplot <<- EOF
		set notitle
		unset xtics
		set xtics ("02" 13, "04" 25, "06" 37, "08" 49, "10" 61, "12" 73, "14" 85, "16" 97, "18" 109, "20" 121, "22" 133, "24" 143)
			set xlabel "time"
		set ylabel "download speed in KB/s"
		set xrange[0:143]
		set yrange[0:2000]
			set term eps
			set output "nelson.eps"
			plot ${liste}
	EOF