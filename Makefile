all: gpg

gpg:
	# PHP key
	wget -q https://packages.sury.org/php/apt.gpg -O php/sury.gpg
	# Node key
	wget -q https://deb.nodesource.com/gpgkey/nodesource.gpg.key -O node/node.gpg
