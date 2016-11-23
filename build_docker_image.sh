#!/usr/bin/env bash
read -p "Choose a version: (5) *PHP 5.6 (7) PHP 7: " CONDITION;
if [[ ("$CONDITION" == "5") ]]; then
	VERSION="5.6"
elif [[ ("$CONDITION" == "7") ]]; then
	VERSION="7.0"
else
	VERSION="5.6"
fi

echo 'Choosed version: ' $VERSION

echo '#######################################'
echo '#         deleting old images         #'
echo '#######################################'
docker rmi $(docker images macielbombonato/ubuntu-php:$VERSION -q)

echo '#################################'
echo '#        building image         #'
echo '#################################'
docker build --rm -t macielbombonato/ubuntu-php:$VERSION -f $VERSION/Dockerfile .
