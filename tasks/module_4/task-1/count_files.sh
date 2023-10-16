#!/bin/bash

count=$(find . -type f | wc -l)
echo "Total number of files is $count"