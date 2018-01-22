#!/bin/sh

# fail on error
set -eu


docker build -t eleks/base-ubuntu-jdk8-groovy -f Dockerfile-ubuntu .
echo $'\nSUCCESS'


read -rsp $'\n-------------------------------------\nPress enter to build next\nor Ctrl+C to terminate...\n-------------------------------------\n'


echo $'\nBuilding alpine'

docker build -t eleks/base-alpine-jdk8-groovy -f Dockerfile-alpine .

echo $'\nPublishing ubuntu...'
docker push eleks/base-ubuntu-jdk8-groovy
echo $'\nPublishing alpine...'
docker push eleks/base-alpine-jdk8-groovy
