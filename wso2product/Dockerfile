# ------------------------------------------------------------------------
FROM eleks/base-ubuntu-jdk8-groovy:latest

ARG WSO2_PRODUCT=PLEASE_SPECIFY
ENV WSO2_HOME      /opt/$WSO2_PRODUCT
ENV DEPLOY_TARGET  /opt/$WSO2_PRODUCT

COPY ./files/${WSO2_PRODUCT}.zip ./
RUN unzip ./${WSO2_PRODUCT}.zip && \
	rm -f ./${WSO2_PRODUCT}.zip

EXPOSE 9443 8280 8243

ENTRYPOINT set -eu && \
	gcli deploy && \
	$WSO2_HOME/bin/wso2server.sh
