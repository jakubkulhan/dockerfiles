FROM debian:bullseye

COPY . /tmp/

RUN set -ex \
	&& apt-get update \
	&& apt-get install -y --no-install-suggests --no-install-recommends \
		apt-transport-https \
		ca-certificates \
		dirmngr \
		gnupg \
		lsb-release \
		curl \
	&& curl -sSLo /tmp/debsuryorg-archive-keyring.deb https://packages.sury.org/debsuryorg-archive-keyring.deb \
	&& dpkg -i /tmp/debsuryorg-archive-keyring.deb \
	&& echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/sury.list \
	&& apt-get update \
	&& apt-get install -y --no-install-suggests --no-install-recommends \
		php8.2-cli \
	&& apt-get remove -y \
		lsb-release \
	&& apt-get autoremove -y \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["php"]
