#!/bin/bash
#===============================================================================
#
#          FILE:  build_client.sh
# 
#         USAGE:  ./build_client.sh 
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
#       CREATED:  25/10/23 13:54:15 CEST
#      REVISION:  ---
#===============================================================================


repo="https://github.com/EPAM-JS-Competency-center/shop-angular-cloudfront"
source_dir="repo_dir"
dist_dir="./dist"
env_configuration="production"

git clone $repo $source_dir

cd "$source_dir"

# Check if client-app.zip exists, and if so, remove it
if [ -f "$dist_dir/client-app.zip" ]; then
	echo "client-app.zip found!"
	rm "$dist_dir/client-app.zip"
fi

# Install dependencies
npm install

# Build the app 
npm run build -- --configuration=$env_configuration

# Create a zip file of the built content
zip -r "$dist_dir/client-app.zip" $dist_dir

# Display the files count
file_count=$(find "$dist_dir" -type f | wc -l)
echo "Number of files in the dist folder: $file_count"  

