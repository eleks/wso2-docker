# ------------------------------------------------------------------------
FROM eleks/base-ubuntu-jdk8-groovy:latest

ARG WSO2_PRODUCT=PLEASE_SPECIFY
ARG ENTRYPOINT=wso2server.sh
ENV WSO2_HOME      /opt/$WSO2_PRODUCT
ENV DEPLOY_TARGET  /opt/$WSO2_PRODUCT
ENV ENTRYPOINT     $ENTRYPOINT

COPY ./files/${WSO2_PRODUCT}.zip ./
RUN unzip ./${WSO2_PRODUCT}.zip && \
	rm -f ./${WSO2_PRODUCT}.zip

EXPOSE 9443 8280 8243

ENTRYPOINT set -eu && \
	gcli deploy && \
	echo "$WSO2_HOME/bin/${ENTRYPOINT}" && \
	$WSO2_HOME/bin/${ENTRYPOINT}
