#!/bin/sh

if [ `id -u` -ne '0' ]; then
	echo "EXIT[ERR]: need to run as root, exiting"
	exit -1
fi

apt update
DEBIAN_FRONTEND=noninteractive apt -y install openssh-server

#grep "PasswordAuth" /etc/ssh/sshd_config
#sudo service ssh restart
