#!/bin/bash
#===============================================================================
#
#          FILE:  count_files.sh
# 
#         USAGE:  ./count_files.sh 
# 
#   DESCRIPTION:  Count number of files
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Mostafa Zaki (), mosafazke@gmail.com
#       COMPANY:  _
#       VERSION:  1.0
#       CREATED:  24/10/23 14:31:29 CEST
#      REVISION:  ---
#===============================================================================




if [ -z "$1" ]; then
  echo "Please provide a directory path as an argument."
  exit 1
fi

directory="$1"
file_count=$(find "$directory" -type f | wc -l)

echo "Number of files in $directory and its subdirectories: $file_count"
