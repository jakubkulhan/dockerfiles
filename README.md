# Dockerfiles

## `php:7`

[![](https://badge.imagelayers.io/jakubkulhan/php:7.svg)](https://imagelayers.io/?images=jakubkulhan/php:7 'Get your own badge on imagelayers.io')

- Based on `debian:jessie` image.
- Installs `php7.0-cli` package.
- Additional PHP extensions can be installed basing on this image:

```
FROM jakubkulhan/php:7

RUN set -ex && \
	apt-get update && \
	apt-get install -y php7.0-intl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
```

## `php:7-fpm`

[![](https://badge.imagelayers.io/jakubkulhan/php:7-fpm.svg)](https://imagelayers.io/?images=jakubkulhan/php:7-fpm 'Get your own badge on imagelayers.io')

- Based on `jakubkulhan/php:7` (therefor `debian:jessie`) image.
- Additionally installs `php7.0-fpm` and provides basic configuration:
  - Logs from FPM and worker processes are redirected to stderr.
  - Pool `www` with dynamic process management configuration (min 4, max 64 workers), `memory_limit = 64M` and `open_basedir = /srv`.
- Add your application to `/srv`, "document root" is `/srv/www`:

```
FROM jakubkulhan/php:7-fpm
COPY . /srv
```

## `java:8-jdk`

[![](https://badge.imagelayers.io/jakubkulhan/java:8-jdk.svg)](https://imagelayers.io/?images=jakubkulhan/java:8-jdk 'Get your own badge on imagelayers.io')

- Java 8 JDK.

## `java:8-jre`

[![](https://badge.imagelayers.io/jakubkulhan/java:8-jre.svg)](https://imagelayers.io/?images=jakubkulhan/java:8-jre 'Get your own badge on imagelayers.io')

- Java 8 JRE.

## `nginx:latest`

[![](https://badge.imagelayers.io/jakubkulhan/nginx:latest.svg)](https://imagelayers.io/?images=jakubkulhan/nginx:latest 'Get your own badge on imagelayers.io')

- Nginx with better default configuration:
  - Default server will reject unknown host, not default to first defined host.
  - SSL settings goodies.
    - Contains pre-generated non-standard elliptic curve for DH key exchange, however, you should generate and use one yourself and mount it to `/etc/nginx/ssl/dhparam2048.pem`.
- Mount volume with HTTP sites configuration to `/etc/nginx/sites`, Nginx will pick it up.
