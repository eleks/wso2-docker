# ------------------------------------------------------------------------
FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive
ENV GROOVY_VERSION 2.4.12

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV GROOVY_HOME /opt/groovy

ENV PATH $PATH:$JAVA_HOME/bin:$GROOVY_HOME/bin

#common packages
RUN set -o errexit -o nounset && \
	echo common packages && \
	apt-get update && \
	apt-get install -y --no-install-recommends apt-utils && \
	apt-get install -y curl unzip mc iputils-ping inetutils-traceroute && \
	apt-get update


# java
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  apt-get -y install software-properties-common && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get -y install -y oracle-java8-installer && \
  rm -rf /var/cache/oracle-jdk8-installer

#RUN echo 'JAVA_HOME="/usr/lib/jvm/java-8-oracle"' >> /etc/environment


# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#groovy
RUN set -o errexit -o nounset && \
	echo "Downloading Groovy" && \
	wget -O groovy.zip "https://dist.apache.org/repos/dist/release/groovy/${GROOVY_VERSION}/distribution/apache-groovy-binary-${GROOVY_VERSION}.zip" && \
	\
	echo "Installing Groovy" && \
	unzip groovy.zip && \
	rm groovy.zip && \
	mv "groovy-${GROOVY_VERSION}" "${GROOVY_HOME}/" && \
	ln -s "${GROOVY_HOME}/bin/groovy" /usr/bin/groovy

# RUN echo 'GROOVY_HOME="$GROOVY_HOME"' >> /etc/environment

RUN     alias ll='ls -la'
#set default shell bash
ENV     SHELL /bin/bash
ENV     BASH /bin/bash
# some ubuntu thing...
ENV     DEBIAN_FRONTEND newt

COPY    ./src /

#where to copy during deploy 
ENV DEPLOY_TARGET=PLEASE_REDEFINE
#where deployment artifacts and config templates located 
ENV DEPLOY_SOURCE=/opt/deploy
#where template parameters located 
ENV CONF_SOURCE=/opt/conf

#suppose to map default deployment source locations to external volumes
VOLUME  /opt/conf
VOLUME  /opt/deploy
WORKDIR /opt

RUN     chmod 775 /opt/tools/bin/gcli && \
        ln -s "/opt/tools/bin/gcli" /usr/bin/gcli

#add some commands into bash history
RUN     \
        echo 'gcli help' >> ~/.bash_history && \
        echo 'gcli deploy' >> ~/.bash_history

#download libs
RUN set -o errexit -o nounset && \
	echo "Downloading libs" && \
	wget --no-verbose --content-disposition -P ./tools/lib/ "http://central.maven.org/maven2/org/yaml/snakeyaml/1.18/snakeyaml-1.18.jar"

# test java&groovy
RUN set -o errexit -o nounset && \
	gcli version

# test deploy function
RUN set -o errexit -o nounset && \
	echo "------ Testing -------" && \
	mkdir test && \
	export DEPLOY_TARGET=/opt/test && \
	export CONF_SOURCE=/opt/.defaults/conf && \
	export DEPLOY_SOURCE=/opt/.defaults/deploy && \
	gcli deploy &&\
	echo "------ Template output -------" && \
	cat /opt/test/readme.nfo && \
	echo "------ File output -------" && \
	cat /opt/test/readme.txt && \
	rm -Rf /opt/test


ENTRYPOINT set -eu && \
	gcli "version" && \
	gcli "help" && \
	gcli "dummy"
