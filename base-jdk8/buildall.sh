#!/bin/sh

# fail on error
set -eu

JAVA_VERSION=8u201
echo "building ${JAVA_VERSION}"

docker build -t eleks/base-ubuntu-jdk8:${JAVA_VERSION} --build-arg JAVA_VERSION=${JAVA_VERSION} -f Dockerfile-ubuntu .
echo $'\nSUCCESS'

read -rsp $'\n-------------------------------------\nPress enter to build next\nor Ctrl+C to terminate...\n-------------------------------------\n'


echo $'\nPublishing ubuntu...'

docker push eleks/base-ubuntu-jdk8:${JAVA_VERSION}
