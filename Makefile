all: gpg

gpg:
	# PHP key
	wget -q https://packages.sury.org/php/apt.gpg -O php/sury.gpg
	# Node key
	wget -q https://deb.nodesource.com/gpgkey/nodesource.gpg.key -O node/node.gpg
	for version in 12; do cp node/node.gpg node/$$version/node.gpg; done
	rm node/node.gpg
