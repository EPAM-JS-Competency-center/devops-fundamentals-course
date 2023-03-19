#!/usr/bin/env bash
echo "Enter source code location"
read SOURCE_LOCATION
cd $SOURCE_LOCATION
npm install
declare -A env_variable_names
env_variable_names[development]=""
env_variable_names[production]="production"
echo "Enter environment"
echo "1 - development"
echo "2 - production"
while true
do
	read option
	if [ $option -gt 0 ] && [ $option -lt 3 ]
	then
		break
	fi
done
if [ $option == 1 ]
then
declare ENV_CONFIGURATION=""
fi
if [ $option == 2 ]
then
declare ENV_CONFIGURATION="production"
fi
declare searchedFile=$(find ./dist -name 'client-app.zip')
if [ $searchedFile != '' ]
then
	rm ./dist/client-app.zip
fi
ng build --configuration=$ENV_CONFIGURATION
cd ./dist
7z a -tzip app
mv app.zip client-app.zip
declare qualityFile=$(find /home -name 'quality-check.sh')
$qualityFile
