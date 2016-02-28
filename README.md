# Dockerfiles

## `jakubkulhan/php:7`

- Based on `debian:jessie` image.
- Installs `php7.0-cli`, `php7.0-mysql` & `php7.0-imagick` packages.
- Additional PHP extensions can be installed basing on this image:

```
FROM jakubkulhan/php:7

RUN set -ex && \
	apt-get update && \
	apt-get install -y php7.0-intl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
```

## `jakubkulhan/php:7-fpm`

- Based on `jakubkulhan/php:7` (therefor `debian:jessie`) image.
- Additionally installs `php7.0-fpm` and provides basic configuration:
  - Logs from FPM and worker processes are redirected to stderr.
  - Pool `www` with dynamic process management configuration (min 4, max 64 workers), `memory_limit = 64M` and `open_basedir = /srv`.
- Add your application to `/srv`, "document root" is `/srv/www`:

```
FROM jakubkulhan/php:7-fpm
COPY . /srv
```
