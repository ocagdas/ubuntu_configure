#!/bin/sh

if [ `id -u` -ne '0' ]; then
	echo "EXIT[ERR]: need to run as root, exiting"
	exit -1
fi

# devices like /dev/ttyUSB etc
usermod -aG tty,dialout $USER
