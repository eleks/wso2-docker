#!/bin/sh

# fail on error
set -eu

P=camunda-bpm-tomcat-7.10.0
docker build -t eleks/base-${P} -f Dockerfile-ubuntu --build-arg PRODUCT=${P} --build-arg UNZIP_DIR=/opt/${P}  --build-arg ENTRYPOINT=start-camunda.sh .

read -rsp $'\n-------------------------------------\nPress enter to publish\nor Ctrl+C to terminate...\n-------------------------------------\n'

docker push eleks/base-${P}

echo "ubuntu ${P} SUCCESS"

