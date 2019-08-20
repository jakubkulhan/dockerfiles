FROM debian:stretch

COPY sury.gpg /tmp/sury.gpg

RUN set -ex && \
	apt-get update && \
	apt-get install -y --no-install-suggests --no-install-recommends apt-transport-https lsb-release gnupg dirmngr ca-certificates && \
	echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" >> /etc/apt/sources.list.d/sury.list && \
	apt-key add /tmp/sury.gpg && \
	apt-get update && \
	apt-get install -y --no-install-suggests --no-install-recommends php7.2-cli && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["php"]
