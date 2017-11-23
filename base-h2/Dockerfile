FROM eleks/base-ubuntu-jdk8-groovy:latest

# that's customized version from wso2 
# works for major wso2 servers
ARG H2_VERSION=h2-1.2.140-wso2v3

ENV H2_DATA_DIR /opt/h2-data
ENV H2_BIN_DIR /opt/h2/bin

WORKDIR /opt

RUN     mkdir -p ${H2_BIN_DIR} \
        mkdir -p ${H2_DATA_DIR}

COPY    ./h2-bin/${H2_VERSION}.jar ${H2_BIN_DIR}


VOLUME  ${H2_DATA_DIR}
EXPOSE 1580 1521

ENTRYPOINT set -eu && \
           ls ${H2_BIN_DIR}/h2*.jar && \
           java -cp ${H2_BIN_DIR}/h2*.jar org.h2.tools.Server \
 	            -web -webAllowOthers -webPort 1580 \
 	            -tcp -tcpAllowOthers -tcpPort 1521 \
 	            -baseDir ${H2_DATA_DIR}
