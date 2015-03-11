#!/bin/sh
source /home/pi/mount_testing/config.cfg


IP=$(curl privatefamilycloud.net/ip/)
echo $IP


curl -u '${DOMAIN}-${USER}:${PASSWORD}' "https://www.ovh.com/nic/update?system=dyndns&hostname=${USER}.${DOMAIN}&myip=$IP"

