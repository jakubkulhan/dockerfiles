FROM debian:buster

COPY . /tmp/

RUN set -ex \
	&& apt-get update \
	&& apt-get install -y --no-install-suggests --no-install-recommends \
		apt-transport-https \
		ca-certificates \
		dirmngr \
		gnupg \
		lsb-release \
	&& echo "deb https://deb.nodesource.com/node_14.x $(lsb_release -c -s) main" > /etc/apt/sources.list.d/nodesource.list \
	&& apt-key add /tmp/node.gpg \
	&& apt-get update \
	&& apt-get install -y --no-install-suggests --no-install-recommends \
		nodejs \
	&& apt-get remove -y \
		lsb-release \
	&& apt-get autoremove -y \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["node"]
