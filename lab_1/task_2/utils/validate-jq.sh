#!/bin/bash

function checkJQ {
    if ! command -v jq &> /dev/null; then
        echo "Error: jq is not installed on your system."
        echo "Please install jq:"
        echo
        echo "For Ubuntu/Debian:"
        echo "sudo apt-get install jq"
        echo
        echo "jq installation instructions: https://stedolan.github.io/jq/download/"
        exit 1
    fi
}

checkJQ
