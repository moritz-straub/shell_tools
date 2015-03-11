#!/bin/bash
#
# tool that pings the google DNS Server and logs the whole ping statistics output
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

cd ${LOGFOLDER}
tail -n 3 ${LOGFOLDER}/temp/ping_${HOST}_to_www.txt >>${LOGFOLDER}/${HOST}/ping_${HOST}_to_www_${DATE}.txt
echo "" >>${LOGFOLDER}/${HOST}/ping_${HOST}_to_www_${DATE}.txt
rm -f ${LOGFOLDER}/temp/ping_${HOST}_to_www.txt

NOW=$(date +"%Y-%m-%d %k:%M:%S")

echo "$NOW">${LOGFOLDER}/temp/ping_${HOST}_to_www.txt
ping -c $ping_count 8.8.8.8 | tail -n 2 >>${LOGFOLDER}/temp/ping_${HOST}_to_www.txt
