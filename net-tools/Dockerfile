FROM ubuntu:16.04


RUN set -o errexit -o nounset && \
	apt-get update && \
	apt-get install -y --no-install-recommends apt-utils curl iputils-ping inetutils-traceroute vim dnsutils 

ENTRYPOINT ["bash"]

