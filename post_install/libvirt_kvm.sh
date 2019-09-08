#!/bin/sh

if [ `id -u` -ne '0' ]; then
	echo "EXIT[ERR]: need to run as root, exiting"
	exit -1
fi

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y qemu-kvm libvirt-bin libvirt-dev virt-top  libguestfs-tools virtinst bridge-utils

sudo modprobe vhost_net
sudo lsmod | grep vhost
sudo sed -i '/vhost_net/d' /etc/modules
echo "vhost_net" | sudo tee -a /etc/modules

exit 0
