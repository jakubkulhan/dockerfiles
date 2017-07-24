FROM debian:jessie

MAINTAINER Jakub Kulhan <jakub.kulhan@gmail.com>

COPY dotdeb.gpg /tmp/dotdeb.gpg

RUN set -ex && \
	echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list.d/dotdeb.list && \
	apt-key add /tmp/dotdeb.gpg && \
	apt-get update && \
	apt-get install -y php7.0-cli && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["php"]
