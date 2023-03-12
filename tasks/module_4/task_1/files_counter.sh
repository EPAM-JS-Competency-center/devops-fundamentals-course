#!/bin/bash

# function to count files in directory and its subdirectories
function count_files {
    local dir="$1"
    local file

    echo -n $dir": " ;
    (find "$dir" -type f | wc -l) ;

    # loop through files in directory
    for file in "$dir"/*; do
#       if file is a directory, recursively go inside
        if [ -d "$file" ]; then
            (count_files "$file");
        fi
    done

}

count_files "$1"
