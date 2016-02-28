FROM debian:jessie

MAINTAINER Jakub Kulhan <jakub.kulhan@gmail.com>

ENV JAVA_VERSION_MAJOR=8 \
	JAVA_VERSION_MINOR=74 \
	JAVA_VERSION_BUILD=02 \
	JAVA_PACKAGE=server-jre \
	JAVA_HOME=/opt/jdk \
	PATH=${PATH}:/opt/jdk/bin \
	LANG=C.UTF-8

RUN set -ex && \
	apt-get update && \
	apt-get install -y curl ca-certificates && \
	curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/java.tar.gz \
	http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz && \
	tar -C /opt -xzf /tmp/java.tar.gz && \
	ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jdk && \
	find /opt/jdk/ -maxdepth 1 -mindepth 1 | grep -v jre | xargs rm -rf && \
	cd /opt/jdk/ && \
	ln -s ./jre/bin ./bin && \
	rm -rf \
		/opt/jdk/jre/plugin \
		/opt/jdk/jre/bin/javaws \
		/opt/jdk/jre/bin/jjs \
		/opt/jdk/jre/bin/orbd \
		/opt/jdk/jre/bin/pack200 \
		/opt/jdk/jre/bin/policytool \
		/opt/jdk/jre/bin/rmid \
		/opt/jdk/jre/bin/rmiregistry \
		/opt/jdk/jre/bin/servertool \
		/opt/jdk/jre/bin/tnameserv \
		/opt/jdk/jre/bin/unpack200 \
		/opt/jdk/jre/lib/javaws.jar \
		/opt/jdk/jre/lib/deploy* \
		/opt/jdk/jre/lib/desktop \
		/opt/jdk/jre/lib/*javafx* \
		/opt/jdk/jre/lib/*jfx* \
		/opt/jdk/jre/lib/jfr* \
		/opt/jdk/jre/lib/amd64/libdecora_sse.so \
		/opt/jdk/jre/lib/amd64/libprism_*.so \
		/opt/jdk/jre/lib/amd64/libfxplugins.so \
		/opt/jdk/jre/lib/amd64/libglass.so \
		/opt/jdk/jre/lib/amd64/libgstreamer-lite.so \
		/opt/jdk/jre/lib/amd64/libjavafx*.so \
		/opt/jdk/jre/lib/amd64/libjfx*.so \
		/opt/jdk/jre/lib/ext/jfxrt.jar \
		/opt/jdk/jre/lib/oblique-fonts \
		/opt/jdk/jre/lib/plugin.jar && \
	apt-get remove -y curl && \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["java"]
