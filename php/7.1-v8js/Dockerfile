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
	apt-get install -y git subversion make g++ python curl php7.1-dev glib2.0-dev && \
	git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git /usr/local/depot_tools && \
	export PATH="$PATH:/usr/local/depot_tools" && \
	cd /usr/local/src && \
	fetch v8 && \
	cd /usr/local/src/v8 && \
	git checkout 5.8.301 && \
	gclient sync && \
	tools/dev/v8gen.py -vv x64.release -- is_component_build=true && \
	ninja -C out.gn/x64.release/ && \
	mkdir -p /opt/v8/lib && \
	cp out.gn/x64.release/lib*.so out.gn/x64.release/*_blob.bin /opt/v8/lib/ && \
	mkdir -p /opt/v8/include && \
	cp -R include/* /opt/v8/include/ && \
	git clone https://github.com/phpv8/v8js.git /usr/local/src/v8js && \
	cd /usr/local/src/v8js && \
	git checkout php7 && \
	phpize7.1 && \
	./configure --with-v8js=/opt/v8 && \
	make all test install && \
	{ \
		echo 'extension = v8js.so'; \
	} | tee /etc/php/7.1/mods-available/v8js.ini && \
	ln -s /etc/php/7.1/mods-available/v8js.ini /etc/php/7.1/cli/conf.d/99-v8js.ini && \
	rm -rf /usr/local/depot_tools /usr/local/src/* && \
	apt-get remove -y git subversion make g++ python curl php7.1-dev && \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["php"]
