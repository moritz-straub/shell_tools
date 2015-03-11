#!/bin/bash
source /home/pi/mount_testing/config.cfg
cd /home/pi
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



TODAY=$(date +"%Y-%m-%d")
NOW=$(date +"%Y-%m-%d %k:%M:%S")

TIME=`curl -so /dev/null -w '%{time_total}\n' http://cachefly.cachefly.net/100mb.test`
SIZE=100
SPEED=`echo "scale=3; ${SIZE}/${TIME}" | bc`
DOWN=`echo ${SPEED}'>'12.00 | bc -l`


if [ $DOWN == 1 ]
then
        echo "${NOW} (0 MB/s) DOWN">>${LOGFOLDER}/${HOST}/dl_log_${HOST}_${TODAY}_100M.txt
		echo "">>${LOGFOLDER}/${HOST}/dl_log_${HOST}_${TODAY}_${SIZE}M.txt
		echo "down"
else
        echo "${NOW} (${SPEED} MB/s)">>${LOGFOLDER}/${HOST}/dl_log_${HOST}_${TODAY}_100M.txt
		echo "">>${LOGFOLDER}/${HOST}/dl_log_${HOST}_${TODAY}_${SIZE}M.txt
		echo "${NOW} (${SPEED} MB/s)"
fi


