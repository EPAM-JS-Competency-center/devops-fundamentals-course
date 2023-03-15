#!/usr/bin/env bash

PERCENT=80

if [[ $# -le 0 ]]
then
	echo "Using default value for threshold!"
else
	if [[ $1 =~ ^-?[0-9]+([0-9]+)?$ ]]
	then
		PERCENT=$1
	fi
fi

df -Ph | grep -vE '^Filesystem|tmpfs|cdrom|loop|udev|devfs|map|Applications' | awk '{ print $5,$1 }' | while read data
do
  used=$(echo $data | awk '{print $1}' | sed s/%//g)
  p=$(echo $data | awk '{print $2}')

  if [ $used -ge $PERCENT ]
  then
	  echo "WARNING: The partition \"$p\" has used $used% of total available space - Date: $(date)"
  fi
done



