#!/bin/bash
#
# script that creates a plot from the rsync logs
#

FOLDER=${LOGFOLDER}/*

for f in $FOLDER
do

echo ${f}
DATE=`echo ${f} | cut -f 8 -d "/" | cut -f 5 -d "_" | sed 's/.\{4\}$//'`
#echo $DATE
FROMTO=`echo ${f} | cut -f 8 -d "/" | sed 's/.\{15\}$//'`
#echo $FROMTO

echo -n $DATE>>${LOGFOLDER}/${FROMTO}.txt
echo -n " ">>${LOGFOLDER}/${FROMTO}.txt
SPEED=`cat ${f} | grep "sent" | cut -f 9 -d" "`

n=0
helper=0

for word in $SPEED
do
n=$((n+1))
        helper=`echo "scale=2; $helper+$word" | bc`
done

helper2=`echo "scale=2; $helper/$n" | bc`
#echo $helper2


echo $helper2>>${LOGFOLDER}/${FROMTO}.txt
echo $helper2



done

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