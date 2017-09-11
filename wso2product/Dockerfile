# ------------------------------------------------------------------------
FROM eleks/base-ubuntu-jdk8-groovy:latest

ARG WSO2_PRODUCT=PLEASE_SPECIFY
ARG ENTRYPOINT=wso2server.sh
ARG PORTS="9443 9999 8280 8243"
# 9443 - carbon console
# 9999 - jmx for debug
# 8243 - https esb services port
# 9280 - http esb services port

ENV WSO2_HOME      /opt/$WSO2_PRODUCT
ENV DEPLOY_TARGET  /opt/$WSO2_PRODUCT
ENV ENTRYPOINT     $ENTRYPOINT

COPY ./files/${WSO2_PRODUCT}.zip ./
RUN unzip ./${WSO2_PRODUCT}.zip && \
	rm -f ./${WSO2_PRODUCT}.zip

# we will not populate base products with custom libs
# let's keep this for deploy process 
#RUN \
#	wget --no-verbose --content-disposition -P ${WSO2_HOME}/repository/components/lib/ "https://github.com/eleks/com.eleks.carbon.commons/releases/download/com.eleks.carbon.commons-r32/com.eleks.carbon.commons.jar"


EXPOSE $PORTS

ENTRYPOINT set -eu && \
	gcli deploy && \
	echo "$WSO2_HOME/bin/${ENTRYPOINT}" && \
	$WSO2_HOME/bin/${ENTRYPOINT}
