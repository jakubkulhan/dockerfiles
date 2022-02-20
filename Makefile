all: gpg

gpg:
	# PHP key
	wget -q https://packages.sury.org/php/apt.gpg -O php/sury.gpg
