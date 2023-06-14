#!/bin/bash

cd shop-angular-cloudfront || exit

echo "Running npm audit..."
npm audit
if [ $? -ne 0 ]; then
  echo "npm audit failed"
  exit 1
fi
echo "npm audit completed successfully"

echo "Running npm run lint..."
npm run lint
if [ $? -ne 0 ]; then
  echo "npm run lint failed"
  exit 1
fi
echo "npm run lint completed successfully"

echo "Running npm run test..."
npm run test
if [ $? -ne 0 ]; then
  echo "npm run test failed"
  exit 1
fi
echo "npm run test completed successfully"
