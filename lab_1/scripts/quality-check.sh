#!/bin/bash
#===============================================================================
#
#          FILE:  quality-check.sh
# 
#         USAGE:  ./quality-check.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Mostafa Zaki (), mosafazke@gmail.com
#       COMPANY:  _
#       VERSION:  1.0
#       CREATED:  31/10/23 10:44:54 CET
#      REVISION:  ---
#===============================================================================
Green='\033[0;32m' # Green
NC='\033[0m' # No Color

source_dir="repo_dir"
cd "$source_dir"

echo -e "${Green}Running linting...${NC}"
npm run lint
echo -e "${Green}Running unit tests...${NC}"
npm run test
echo -e "${Green}Running audit for security check...${NC}"
npm audit

if [ $? -eq 0 ]; then
  echo "Quality check passed!"
	exit 0
else
  echo "Quality check failed!"
  exit 1
fi
