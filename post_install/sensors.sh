#!/bin/sh

if [ `id -u` -ne '0' ]; then
	echo "EXIT[ERR]: need to run as root, exiting"
	exit -1
fi

apt-get update
DEBIAN_FRONTEND=noninteractive apt install -y \
	lm-sensors hddtemp psensor

snap install sensors-unity
snap connect sensors-unity:hardware-observe :hardware-observe

echo "sudo sensors-detect --auto" >> run_manually.sh

