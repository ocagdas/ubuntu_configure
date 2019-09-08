#!/bin/sh

if [ `id -u` -ne '0' ]; then
	echo "EXIT[ERR]: need to run as root, exiting"
	exit -1
fi


sudo killall VBoxHeadless >/dev/null 2>&1
sudo killall VirtualBox >/dev/null 2>&1

distro_codename=$(cat /etc/*-release | grep "CODENAME=" | tail -n1 | sed 's@.*=\(.*\)@\1@')

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

sudo add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian $distro_codename contrib"

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get remove -y --purge virtualbox-*
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y virtualbox virtualbox-ext-pack virtualbox-qt

VBoxManage --version

mkdir -p /media/$USER/ExtraStorageEnc/vms
vboxmanage setproperty machinefolder /media/$USER/ExtraStorageEnc/vms

sudo usermod -aG vboxusers $SUDO_USER
echo "sudo usermod -aG vboxusers $USER" >> run_manually.sh

exit 0
