#!/usr/bin/env bash

# Check free space against %d percent threshold

DEFAULT_THRESHOLD=10

if [ -z "$1" ]; then
    echo "Will use default threshold $DEFAULT_THRESHOLD";
    threshold_in_percent=$DEFAULT_THRESHOLD;
else
    if ! [[ $1 =~ ^[1-9][0-9]?$ ]]; then
        echo "Free space threshold must be defined in percents from 1 and 99.";
        exit 1;
    else
        threshold_in_percent=$1;
    fi
fi

while true
do
    used=$(df / | awk 'NR==2 {print $5}' | cut -d'%' -f1);
    free=$((100 - $used));
    printf "Checking free space against %d percent threshold...\n" $threshold_in_percent;
    if [ "$free" -le "$threshold_in_percent" ]
    then
        printf "Free space: %d\n (less then threshold)" $free;
    fi
    sleep 60
done



