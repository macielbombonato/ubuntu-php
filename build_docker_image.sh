#!/usr/bin/env bash
echo '#######################################'
echo '#         deleting old images         #'
echo '#######################################'
docker rmi $(docker images macielbombonato/ubuntu-php-cake -q)

echo '#################################'
echo '#        building image         #'
echo '#################################'
docker build --rm -t macielbombonato/ubuntu-php-cake .
