#!/bin/bash

runQualityCheckerFunction() {
 echo "Running $1..."
 $1
 if [ $? -ne 0 ]; then
   echo "$1 has been failed"
   exit 1
 fi
 echo "$1 has been completed successfully"
}

cd shop-angular-cloudfront

runQualityCheckerFunction "npm run lint"
runQualityCheckerFunction "npm run test"
runQualityCheckerFunction "npm run audit --fix"

echo "DONE"
