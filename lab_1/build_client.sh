#!/bin/bash

COMPRESSED_FILE_NAME="client-app.zip"

function removeAppIfExists() {
	if [ -f $COMPRESSED_FILE_NAME ]; then
		rm -f $COMPRESSED_FILE_NAME
		echo "Compressed app has been deleted"
	else
		echo "App has not been compressed yet"
	fi
}

read -p "Please enter configuration: " ENV_CONFIGURATION

git clone "https://github.com/EPAM-JS-Competency-center/shop-angular-cloudfront.git"

cd shop-angular-cloudfront

npm install

npm run build --configuration=$ENV_CONFIGURATION

cd dist

removeAppIfExists

zip -r $COMPRESSED_FILE_NAME *

echo "App has been compressed, path: dist/$COMPRESSED_FILE_NAME"

echo "DONE"
