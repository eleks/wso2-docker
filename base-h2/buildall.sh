#!/bin/sh

# fail on error
set -eu


P=h2-1.2.140-wso2v3
docker build -t eleks/base-${P} -f Dockerfile-ubuntu --build-arg H2_VERSION=${P} .
docker push eleks/base-${P}


# P=h2-1.2.140-wso2v3
# docker build -t eleks/alpine-${P} -f Dockerfile-alpine --build-arg H2_VERSION=${P} .
# docker push eleks/alpine-${P}



echo "SUCCESS"
