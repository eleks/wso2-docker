#!/bin/sh
set -eu

CN=*.docker.local
PASS=wso2carbon

# as alternative we can connect to hosts by docker-machine ip
EXTERNAL_IP=${NO_PROXY}

# replace * with _ for filename
CNF=$( echo $CN | tr "*" _ )

keytool -genkey -v -validity 5357 -alias ${CN} -keyalg RSA -keystore wso2carbon.jks -storepass ${PASS} -keypass ${PASS} -dname "CN=${CN}, OU=, O=ELEKS, L=Lviv, S=, C=UA" -ext SAN=dns:${CN},ip:${EXTERNAL_IP}

keytool -certreq -alias ${CN} -keyalg RSA -keystore wso2carbon.jks -storepass wso2carbon > ${CNF}.csr
