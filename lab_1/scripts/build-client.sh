#!/bin/bash

repository="https://github.com/EPAM-JS-Competency-center/shop-angular-cloudfront.git"
localFolder="/Users/$USER/Desktop/DOF/EPAM-JS-Competency-center"
compressedClientApp="/Users/$USER/Desktop/DOF/EPAM-JS-Competency-center/dist/client-app.zip"
dist="/Users/$USER/Desktop/DOF/EPAM-JS-Competency-center/dist/"

ENV_CONFIGURATION=''

git clone "$repository" "$localFolder"

cd "$localFolder" || exit

npm install
npm run-script build --configuration="$ENV_CONFIGURATION"

if [ -f "$compressedClientApp" ]; then
  echo "Compressed client app already exists";
  rm -i "$compressedClientApp"
  echo "Compressed client app was deleted";
fi

zip -r client-app.zip "$dist"
