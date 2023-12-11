#!/bin/bash

if [ -n "$1" ]; then
    directory="$1"
else
    directory="$(pwd)"
fi

cd "$directory"

echo "Running linting..."
npx eslint . --ignore-path .gitignore --ext .ts

echo "Running unit tests..."

test_output=$(npm run test)

if echo "$test_output" | grep -q "TOTAL:"; then
    echo "String 'TOTAL:' found. Continuing..."
else
    echo "String 'TOTAL:' not found. Exiting."
    exit 1
fi

echo "Running npm audit..."
audit_result=$(npm audit)

if [[ $audit_result == *"found"* ]]; then
    echo "Running npm audit fix..."
    npm audit fix
fi

echo "Quality check complete."
