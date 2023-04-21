#!/usr/bin/env bash

COLOR_WARNING='\e[33m'
COLOR_ALERT='\e[31m'
COLOR_RESET='\e[0m'
BEEP='\a'

CODE_INVALID_ARGUMENTS=1
CODE_FREESPACE_BELOW_THRESHOLD=2

while getopts "d:t:" opt; do
    case $opt in
    d) directory=$OPTARG ;;
    t) threshold=$OPTARG ;;
    *)
        echo "Usage: [-d directory] [-t threshold]" >&2
        exit $CODE_INVALID_ARGUMENTS
        ;;
    esac
done

if [ -z "${directory}" ]; then
    directory="$(pwd)"
    echo -e "${COLOR_WARNING}No directory specified, using current directory: ${directory}${COLOR_RESET}"
else
    echo "Directory: ${directory}"
fi

if [ -z "${threshold}" ]; then
    threshold=10
    echo -e "${COLOR_WARNING}No threshold specified, using default value (in Gb): ${threshold}${COLOR_RESET}"
else
    echo "Threshold (in Gb): ${threshold}"
fi

declare -i freespace

while true; do
    freespace=$(df -BG --output=avail "$directory" | tail -n 1 | tr -d 'G' | xargs)

    if [ "${freespace}" -lt "${threshold}" ]; then
        echo -ne "${BEEP}${BEEP}${BEEP}"
        echo -e "${COLOR_ALERT}Alert: free space is less than ${threshold} Gb${COLOR_RESET}"
        echo "Free space left (in Gb): ${freespace}"
        exit $CODE_FREESPACE_BELOW_THRESHOLD
    fi

    sleep 10
done
