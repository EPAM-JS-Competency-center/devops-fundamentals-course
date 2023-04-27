#!/bin/bash

cd ~/Desktop/Devops-fundamentals/EPAM-JS-Competency-center/ || exit

echo "Running linting..."
npm run lint

echo "Running unit tests..."
npm run test

echo "Running npm audit..."
npm audit

if [ $? -eq 0 ]; then
  echo "Code quality checks passed!"
else
  echo "Code quality checks failed. Please check the logs for more information."
  exit 1
fi
