#!/bin/sh

if [ `id -u` -ne '0' ]; then
	echo "EXIT[ERR]: need to run as root, exiting"
	exit -1
fi

DEBIAN_FRONTEND=noninteractive apt-get install -y --reinstall ubuntu-gnome-desktop

echo "current display manager: "
cat /etc/X11/default-display-manager
