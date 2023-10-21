#!/bin/bash

directory="$1"

if [ ! -d "$directory" ]; then
  echo "The directory doesn't exist."
  exit 1
fi

file_count=$(find "$directory" -type f | wc -l)

echo "$file_count count the number of files in $directory"