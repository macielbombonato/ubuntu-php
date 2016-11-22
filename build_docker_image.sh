#!/usr/bin/env bash
read -p "Choose a version: (1) *PHP 5.6 Cake 2 (2) PHP 5.6 Cake 3 (3) PHP 7 Cake 3 --> " CONDITION;
if [[ ("$CONDITION" == "1") ]]; then
	VERSION="php56-cake2"
elif [[ ("$CONDITION" == "2") ]]; then
	VERSION="php56-cake3"
elif [[ ("$CONDITION" == "3") ]]; then
	VERSION="php70-cake3"
else
	VERSION="php56-cake2"
fi

echo 'Choosed version: ' $VERSION

echo '#######################################'
echo '#         deleting old images         #'
echo '#######################################'
docker rmi $(docker images macielbombonato/ubuntu-php-cake:$VERSION -q)

echo '#################################'
echo '#        building image         #'
echo '#################################'
docker build --rm -t macielbombonato/ubuntu-php-cake:$VERSION -f $VERSION/Dockerfile .
