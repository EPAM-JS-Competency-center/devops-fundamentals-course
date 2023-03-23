#!/bin/bash

repository="https://github.com/EPAM-JS-Competency-center/shop-angular-cloudfront.git"
localFolder="/Users/$USER/Desktop/Devops-fundamentals/EPAM-JS-Competency-center"
compressedClientApp="/Users/$USER/Desktop/Devops-fundamentals/EPAM-JS-Competency-center/dist/client-app.tar.gz"
clientAppDir="/Users/$USER/Desktop/Devops-fundamentals/EPAM-JS-Competency-center/dist/app/"
dist="/Users/$USER/Desktop/Devops-fundamentals/EPAM-JS-Competency-center/dist/"
ENV_CONFIGURATION=''

git clone "$repository" "$localFolder"

cd "$localFolder" || exit

npm install

npm run-script build --configuration="$ENV_CONFIGURATION"

if [ -f "$compressedClientApp" ]; then
  echo "We've already have compressed file";
  rm -i "$compressedClientApp"
  echo "Compressed client app was deleted";
fi

tar -zcvf client-app.tar.gz "$clientAppDir"

mv client-app.tar.gz "$dist"

