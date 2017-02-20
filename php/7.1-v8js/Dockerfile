FROM debian:jessie

MAINTAINER Jakub Kulhan <jakub.kulhan@gmail.com>

COPY sury.gpg /tmp/sury.gpg

RUN set -ex && \
	apt-get update && \
	apt-get install -y apt-transport-https lsb-release ca-certificates && \
	echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" >> /etc/apt/sources.list.d/sury.list && \
	apt-key add /tmp/sury.gpg && \
	apt-get update && \
	apt-get install -y php7.1-cli && \
	apt-get install -y git subversion make g++ python curl php7.1-dev chrpath && \
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
	cd /usr/local/src/v8js && git checkout php7 && phpize7.1 && ./configure --with-v8js=/usr/local && make all test install && \
	{ \
		echo 'extension = v8js.so'; \
	} | tee /etc/php/7.1/mods-available/v8js.ini && \
	ln -s /etc/php/7.1/mods-available/v8js.ini /etc/php/7.1/cli/conf.d/99-v8js.ini && \
	ln -s /etc/php/7.1/mods-available/v8js.ini /etc/php/7.1/fpm/conf.d/99-v8js.ini && \
	rm -rf /usr/local/depot_tools /usr/local/src/* && \
	apt-get remove -y git subversion make g++ python curl php7.1-dev chrpath && \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["php"]
