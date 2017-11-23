#!/bin/sh

# fail on error
set -eu

docker build -t eleks/base-h2 .
docker push eleks/base-h2


echo "SUCCESS"
