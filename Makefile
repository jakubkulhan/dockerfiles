all:
	# nothing to see here

gpg:
	# PHP key
	wget -q https://packages.sury.org/php/apt.gpg -O php/sury.gpg
	for version in 7.1 7.1-fpm 7.1-fpm-v8js 7.1-v8js 7.2 7.2-fpm 7.3 7.3-fpm; do cp php/sury.gpg php/$$version/sury.gpg; done
	rm php/sury.gpg
	# Node key
	wget -q https://deb.nodesource.com/gpgkey/nodesource.gpg.key -O node/node.gpg
	for version in 9; do cp node/node.gpg node/$$version/node.gpg; done
	rm node/node.gpg
