#!/bin/sh

# fail on error
set -eu

echo "build 4 ubuntu"

P=wso2bps-3.6.0
docker build -t eleks/base-${P} -f Dockerfile-ubuntu --build-arg WSO2_PRODUCT=${P} .
docker push eleks/base-${P}

P=wso2bps-3.5.1
docker build -t eleks/base-${P} -f Dockerfile-ubuntu --build-arg WSO2_PRODUCT=${P} .
docker push eleks/base-${P}

P=wso2esb-4.9.0
docker build -t eleks/base-${P} -f Dockerfile-ubuntu --build-arg WSO2_PRODUCT=${P} .
docker push eleks/base-${P}

P=wso2esb-5.0.0
docker build -t eleks/base-${P} -f Dockerfile-ubuntu --build-arg WSO2_PRODUCT=${P} .
docker push eleks/base-${P}

P=wso2is-5.3.0
docker build -t eleks/base-${P} -f Dockerfile-ubuntu --build-arg WSO2_PRODUCT=${P} .
docker push eleks/base-${P}

P=wso2is-analytics-5.3.0
docker build -t eleks/base-${P} -f Dockerfile-ubuntu --build-arg WSO2_PRODUCT=${P} .
docker push eleks/base-${P}

echo "ubuntu SUCCESS"

echo "build 4 alpine"

P=wso2bps-3.6.0
docker build -t eleks/alpine-${P} -f Dockerfile-alpine --build-arg WSO2_PRODUCT=${P} .
docker push eleks/alpine-${P}

P=wso2bps-3.5.1
docker build -t eleks/alpine-${P} -f Dockerfile-alpine --build-arg WSO2_PRODUCT=${P} .
docker push eleks/alpine-${P}

P=wso2esb-4.9.0
docker build -t eleks/alpine-${P} -f Dockerfile-alpine --build-arg WSO2_PRODUCT=${P} .
docker push eleks/alpine-${P}

P=wso2esb-5.0.0
docker build -t eleks/alpine-${P} -f Dockerfile-alpine --build-arg WSO2_PRODUCT=${P} .
docker push eleks/alpine-${P}

P=wso2is-5.3.0
docker build -t eleks/alpine-${P} -f Dockerfile-alpine --build-arg WSO2_PRODUCT=${P} .
docker push eleks/alpine-${P}

P=wso2is-analytics-5.3.0
docker build -t eleks/alpine-${P} -f Dockerfile-alpine --build-arg WSO2_PRODUCT=${P} .
docker push eleks/alpine-${P}

echo "ubuntu SUCCESS"
