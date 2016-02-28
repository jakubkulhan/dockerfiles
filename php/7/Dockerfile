FROM debian:jessie

COPY dotdeb.gpg /tmp/dotdeb.gpg

RUN set -ex && \
	echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list.d/dotdeb.list && \
	apt-key add /tmp/dotdeb.gpg && \
	apt-get update && \
	apt-get install -y php7.0-cli php7.0-mysql php7.0-imagick && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["php"]
