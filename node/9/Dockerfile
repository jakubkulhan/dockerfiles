FROM debian:stretch

COPY node.gpg /tmp/node.gpg

RUN set -ex && \
	apt-get update && \
	apt-get install -y --no-install-suggests --no-install-recommends apt-transport-https lsb-release gnupg dirmngr ca-certificates && \
	echo "deb https://deb.nodesource.com/node_9.x $(lsb_release -c -s) main" > /etc/apt/sources.list.d/nodesource.list && \
	apt-key add /tmp/node.gpg && \
	apt-get update && \
	apt-get install -y --no-install-suggests --no-install-recommends nodejs && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["node"]
