#!/bin/sh

# fail on error
set -eu


docker build -t eleks/net-tools .
docker push eleks/net-tools

