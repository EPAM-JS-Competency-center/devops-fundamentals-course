#!/usr/bin/env bash

DIRECTORY=$(pwd)

if [[ $# -le 0 ]]
then
  echo "Using the current directory"
else
  DIRECTORY=$1
fi

echo $(ls -1R $DIRECTORY | grep "^." | wc -l) "files"


