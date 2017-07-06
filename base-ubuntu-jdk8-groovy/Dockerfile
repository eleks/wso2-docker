# ------------------------------------------------------------------------
FROM ubuntu:latest
MAINTAINER dlukyanov@ukr.net

ENV DEBIAN_FRONTEND noninteractive
ENV GROOVY_VERSION 2.4.12

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV GROOVY_HOME /opt/groovy

ENV PATH $PATH:$JAVA_HOME/bin:$GROOVY_HOME/bin

RUN alias ll='ls -al'

#common packages
RUN set -o errexit -o nounset && \
	echo common packages && \
	apt-get update && \
	apt-get install -y --no-install-recommends apt-utils && \
	apt-get install -y curl unzip mc && \
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


RUN set -o errexit -o nounset && \
	echo "------ Testing -------" && \
	java -version && \
	groovy --version

ENV DEBIAN_FRONTEND newt

CMD bash
