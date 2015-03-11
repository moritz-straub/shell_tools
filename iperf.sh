#!/bin/bash
#
# tool that connects to a remote iperf server and logs the bandwidth
#
source /home/pi/mount_testing/config.cfg

case "$HOSTNAME" in
        VPNserver) HOST="moritz"
        ;;
        backupPI) HOST="jakob"
        ;;
        lisaPI) HOST="lisa"
        ;;
        maxPI) HOST="max"
        ;;
		nelsonPI) HOST="nelson"
		;;
		fabianPI) HOST="fabian"
		;;
esac

DATE=$(date +"%Y-%m-%d")
for i in "${hosts[@]}"
do
	if [ $HOST != $i ]
	then
	templog=${LOGFOLDER}/iperf_${HOST}_to_${i}.txt
	log=${LOGFOLDER}/${HOST}/iperf_log_${HOST}_to_${i}_${DATE}.txt
		echo "iperfing from ${HOST} to ${i}"
		NOW=$(date +"%Y-%m-%d %k:%M:%S")
		iperf -c $i -p 11111 -f m >> $templog
		echo -e "${NOW} $(awk '/Bandwidth/ {getline}; END{print $7, $8}' $templog)" >> $log
	fi
done
