#!/bin/bash

# default value to use if none specified
THRESHOLD=30

# test for command line argument is present
if [[ $# -le 0 ]]
then
    printf "Using default value for threshold!\n"
# test if argument is an integer
# if it is, use that as percent, if not use default
else
    if [[ $1 =~ ^-?[0-9]+([0-9]+)?$ ]]
    then
        THRESHOLD=$1
    fi
fi

let "THRESHOLD += 0"
printf "Threshold = %d\n" $THRESHOLD

df -Ph | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5,$1 }' | while read data;
do
    used=$(echo $data | awk '{print $1}' | sed s/%//g)
    if [ $used -ge $THRESHOLD ]
    then
      partition=$(echo $data | awk '{print $2}')
      echo "WARNING: The partition \"$partition\" has used $used% of total available space - Date: $(date)"
    fi
done
