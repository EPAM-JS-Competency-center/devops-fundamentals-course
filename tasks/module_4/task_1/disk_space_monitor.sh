#!/bin/bash
#===============================================================================
#
#          FILE:  disk_space_monitor.sh
# 
#         USAGE:  ./disk_space_monitor.sh 
# 
#   DESCRIPTION:  Watch free disk space
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Mostafa Zaki (), mosafazke@gmail.com
#       COMPANY:  _
#       VERSION:  1.0
#       CREATED:  24/10/23 14:22:50 CEST
#      REVISION:  ---
#===============================================================================

DEFAULT_THRESHOLD=1000

THRESHOLD=${1:-$DEFAULT_THRESHOLD}


while true; do
	free_space=$(df -m / | awk 'NR==2 {print $4}')
	if [ "$free_space" -lt "$THRESHOLD" ]; then
		echo "Warning: Free disk space is lower than threshold ($THRESHOLD MB)!"
	fi
	sleep 300 # sleep for 5 minutes
done
