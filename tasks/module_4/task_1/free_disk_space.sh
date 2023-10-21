#!/bin/bash

DEFAULT_THRESHOLD_MB=1

if [ "$#" -eq 0 ]; then
  THRESHOLD_MB=$DEFAULT_THRESHOLD_MB
else
  THRESHOLD_MB=$1
fi

FREE_SPACE_MB=$(df -m / | awk 'NR==2 {print $4}')

if [ "$FREE_SPACE_MB" -lt "$THRESHOLD_MB" ]; then
echo "A free space drops below a given $FREE_SPACE_MB MB"
fi