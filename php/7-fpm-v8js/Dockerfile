FROM debian:jessie

MAINTAINER Jakub Kulhan <jakub.kulhan@gmail.com>

COPY dotdeb.gpg /tmp/dotdeb.gpg

RUN set -ex && \
	echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list.d/dotdeb.list && \
	apt-key add /tmp/dotdeb.gpg && \
	apt-get update && \
	apt-get install -y php7.0-cli php7.0-fpm && \
	update-alternatives --install /usr/sbin/php-fpm php-fpm /usr/sbin/php-fpm7.0 0 && \
	cp /etc/php/7.0/fpm/php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf.dist && \
	{ \
		echo '[global]'; \
		echo 'error_log = /proc/self/fd/2'; \
		echo 'daemonize = no'; \
		echo 'include = /etc/php/7.0/fpm/pool.d/*.conf'; \
	} | tee /etc/php/7.0/fpm/php-fpm.conf && \
	cp /etc/php/7.0/fpm/pool.d/www.conf /etc/php/7.0/fpm/pool.d/www.conf.dist && \
	{ \
		echo '[www]'; \
		echo 'user = www-data'; \
		echo 'group = www-data'; \
		echo 'listen = [::]:9000'; \
		echo 'pm = dynamic'; \
		echo 'pm.max_children = 64'; \
		echo 'pm.start_servers = 4'; \
		echo 'pm.min_spare_servers = 4'; \
		echo 'pm.max_spare_servers = 32'; \
		echo 'pm.max_requests = 0'; \
		echo 'pm.status_path = /fpm-status'; \
		echo 'access.log = /proc/self/fd/2'; \
		echo 'slowlog = /proc/self/fd/2'; \
		echo 'request_slowlog_timeout = 1'; \
		echo 'chdir = /srv/www'; \
		echo 'catch_workers_output = yes'; \
		echo 'security.limit_extensions = .php'; \
		echo 'php_flag[display_errors] = on'; \
		echo 'php_admin_value[error_log] = /proc/self/fd/2'; \
		echo 'php_admin_flag[log_errors] = on'; \
		echo 'php_admin_value[memory_limit] = 64M'; \
		echo 'php_admin_value[open_basedir] = /srv:/tmp'; \
		echo 'php_admin_value[error_reporting] = 32767'; \
	} | tee /etc/php/7.0/fpm/pool.d/www.conf && \
	mkdir /srv/www && \
	{ \
		echo '<?php'; \
		echo 'header("Content-Type: text/plain");'; \
		echo 'echo "It workses!";'; \
	} | tee /srv/www/index.php && \
	chown www-data:www-data /srv/www/index.php && \
	apt-get install -y git subversion make g++ python curl php7.0-dev chrpath && \
	git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git /usr/local/depot_tools && \
	export PATH="$PATH:/usr/local/depot_tools" && \
	cd /usr/local/src && fetch v8 && \
	cd /usr/local/src/v8 && make native library=shared snapshot=off -j4 && \
	mkdir -p /usr/local/lib && \
	cp /usr/local/src/v8/out/native/lib.target/lib*.so /usr/local/lib && \
	{ \
		echo 'create /usr/local/lib/libv8_libplatform.a'; \
		echo 'addlib /usr/local/src/v8/out/native/obj.target/tools/gyp/libv8_libplatform.a'; \
		echo 'save'; \
		echo 'end'; \
	} | ar -M && \
	cp -R /usr/local/src/v8/include /usr/local && \
	chrpath -r '$ORIGIN' /usr/local/lib/libv8.so && \
	git clone https://github.com/phpv8/v8js.git /usr/local/src/v8js && \
	cd /usr/local/src/v8js && git checkout php7 && phpize7.0 && ./configure --with-v8js=/usr/local && make all test install && \
	{ \
		echo 'extension = v8js.so'; \
	} | tee /etc/php/mods-available/v8js.ini && \
	ln -s /etc/php/mods-available/v8js.ini /etc/php/7.0/cli/conf.d/99-v8js.ini && \
	ln -s /etc/php/mods-available/v8js.ini /etc/php/7.0/fpm/conf.d/99-v8js.ini && \
	rm -rf /usr/local/depot_tools /usr/local/src/* && \
	apt-get remove -y git subversion make g++ python curl php7.0-dev chrpath && \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9000

CMD ["/usr/sbin/php-fpm", "-F"]
