#!/bin/sh

if [ `id -u` -ne '0' ]; then
	echo "EXIT[ERR]: need to run as root, exiting"
	exit -1
fi

add-apt-repository ppa:wireshark-dev/stable -y
apt update
DEBIAN_FRONTEND=noninteractive apt -y install wireshark

echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure wireshark-common

sudo usermod -aG wireshark $SUDO_USER
echo 'sudo usermod -aG wireshark $USER' >> run_manually.sh


