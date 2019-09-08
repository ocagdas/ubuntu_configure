#!/bin/sh

if [ `id -u` -ne '0' ]; then
	echo "EXIT[ERR]: need to run as root, exiting"
	exit -1
fi

echo "installing vagrant plugins..."
sudo vagrant plugin install vagrant-libvirt
sudo vagrant plugin install vagrant-disksize
sudo vagrant plugin install vagrant-azure

vagrant plugin list

exit 0
