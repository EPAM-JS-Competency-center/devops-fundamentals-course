#!/bin/bash

SCRIPT_DIR=`dirname "$(readlink -f "$BASH_SOURCE")"`
ROOT_DIR="${SCRIPT_DIR%/*}/app"

cd $ROOT_DIR

echo "Running linter..."
npm run lint
echo "✅ Lint passed"

echo "Running tests..."
npm run test
echo "✅ Tests passed"

echo "Running audit checks..."
npm audit
echo "✅ Audit completed"
