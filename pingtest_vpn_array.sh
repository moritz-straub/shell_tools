#!/bin/bash
#
# tool that pings all remote VPN server and logs the whole ping statistics output
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
			if ping -W 2 -c1 $i > /dev/null
			then
				cd /home/pi/mount_testing/vpnping
				tail -n 3 ${LOGFOLDER}/temp/temp_${HOST}_to_${i}.txt >>${LOGFOLDER}/${HOST}/log_${HOST}_to_${i}_${DATE}.txt
				echo "" >>${LOGFOLDER}/${HOST}/log_${HOST}_to_${i}_${DATE}.txt
				rm -f ${LOGFOLDER}/temp/temp_${HOST}_to_${i}.txt

				NOW=$(date +"%Y-%m-%d %k:%M:%S")

				echo "$NOW">${LOGFOLDER}/temp/temp_${HOST}_to_${i}.txt
				# ping_count from config.cfg
				ping -c $ping_count $i | tail -n 2 >>${LOGFOLDER}/temp/temp_${HOST}_to_${i}.txt &
			else
				echo "host ${i} down - wont ping"
				NOW=$(date +"%Y-%m-%d %k:%M:%S")
				echo "$NOW">>${LOGFOLDER}/${HOST}/log_${HOST}_to_${i}_${DATE}.txt
				echo "HOST DOWN">>${LOGFOLDER}/${HOST}/log_${HOST}_to_${i}_${DATE}.txt
				echo "HOST DOWN = 0/0/0/0 ms">>${LOGFOLDER}/${HOST}/log_${HOST}_to_${i}_${DATE}.txt
				echo "">>${LOGFOLDER}/${HOST}/log_${HOST}_to_${i}_${DATE}.txt
			fi
		else
			echo "skipping ping to $HOST cause its you"
		fi
	done
