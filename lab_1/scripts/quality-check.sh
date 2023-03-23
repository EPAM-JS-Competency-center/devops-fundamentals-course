#!/bin/bash

cd ~/Desktop/Devops-fundamentals/EPAM-JS-Competency-center/ || exit

if npm run lint
then
  echo "npm run lint was passed SUCCESS"
else
  echo "npm run lint was FAILED"
fi

if npm run test
then
  echo "run test was passed SUCCESS"
else
  echo "run test was FAILED"
fi

if npm audit
then
  echo "npm audit was passed SUCCESS"
else
  echo "npm audit was FAILED"
fi
