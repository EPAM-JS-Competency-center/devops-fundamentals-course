#!/bin/bash

# Set default threshold to 10% of disk space
THRESHOLD=${1:-90}

while true
do
    FREE=$(df -h | grep '^/dev/' | awk '{print $5}' | sed 's/%//g' | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/;/g')
    IFS=';' read -ra FREE_ARR <<< "$FREE"

    # Sum up all volumes
    ALL_MEMORY_USED=0;
    for used_volume in "${FREE_ARR[@]}"
        do
            (( ALL_MEMORY_USED += used_volume ))
        done
    echo $ALL_MEMORY_USED;
    # Check if free space is below threshold
    if [ $ALL_MEMORY_USED -gt $THRESHOLD ]
    then
        echo "Warning: Used disk space is above ${THRESHOLD}%"
    fi

    # Wait for 5 seconds
    sleep 5
done
