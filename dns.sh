#!/bin/sh
#
# OVH DynHost updater
#
source /home/pi/mount_testing/config.cfg

# get IP
IP=$(curl privatefamilycloud.net/ip/)
echo $IP

# update DNS
# example: curl -u 'privatefamilycloud.net-host1:secretpassword' "https://www.ovh.com/nic/update?system=dyndns&hostname=host1.privatefamilycloud.net&myip=$IP"
curl -u '${DOMAIN}-${USER}:${PASSWORD}' "https://www.ovh.com/nic/update?system=dyndns&hostname=${USER}.${DOMAIN}&myip=$IP"

