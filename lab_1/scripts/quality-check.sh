#!/bin/bash

PROJECT="shop-angular-cloudfront"

cd "$PROJECT" || exit

echo "Install npm dependencies"
npm ci

echo "Running unit tests..."
ng test --watch=false
echo "Finished unit tests"

echo "Running linting..."
ng lint
echo "Finished lint"

echo "Running e2e..."
ng e2e
echo "Finished e2e"

echo "Running npm audit..."
npm audit
echo "Finished npm audit"

echo "Quality check completed."