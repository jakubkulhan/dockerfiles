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
	&& echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" >> /etc/apt/sources.list.d/sury.list \
	&& apt-key add /tmp/sury.gpg \
	&& apt-get update \
	&& apt-get install -y --no-install-suggests --no-install-recommends \
		php8.0-cli \
		php8.0-fpm \
	&& update-alternatives --install /usr/sbin/php-fpm php-fpm /usr/sbin/php-fpm8.0 0 \
	&& mv /etc/php/8.0/fpm/php-fpm.conf /etc/php/8.0/fpm/php-fpm.conf.dist \
	&& mv /tmp/php-fpm.conf /etc/php/8.0/fpm/php-fpm.conf \
	&& mv /etc/php/8.0/fpm/pool.d/www.conf /etc/php/8.0/fpm/pool.d/www.conf.dist \
	&& mv /tmp/www.conf /etc/php/8.0/fpm/pool.d/www.conf \
	&& mkdir /srv/www \
	&& mv /tmp/index.php /srv/www/index.php \
	&& chown www-data:www-data /srv/www/index.php \
	&& apt-get remove -y \
		lsb-release \
	&& apt-get autoremove -y \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9000

CMD ["/usr/sbin/php-fpm", "-F"]
