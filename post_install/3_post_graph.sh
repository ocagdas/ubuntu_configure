#!/bin/sh

if [ `id -u` -ne '0' ]; then
	echo "EXIT[ERR]: need to run as root, exiting"
	exit -1
fi

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt install -y \
	gddrescue gparted \
	network-manager \
	gitk tortoisehg \
	debconf-utils \
	meld \
	vim-gnome \
	galculator \
	clipit \
	cutecom \
	graphviz \
	synaptic

./wireshark.sh
./anaconda.sh
./arduino.sh
./visual_studio_code.sh
./skype.sh
./sensors.sh
./mic_noise_cancelling.sh

opt_selection="";
while [ "$opt_selection" != "y" ] && [ "$opt_selection" != "n" ]; do
	read -t 10 -p "Do you want to proceed to installing optional packages [Y/n]: " opt_selection;
	opt_selection=${opt_selection,,};
	if [ -z "$opt_selection" ]; then
		opt_selection="y"
	fi
done

if [ "${opt_selection}" == "y" ]; then
	echo "proceeding with the optionals"
	./4_graph_optionals.sh
else
	echo "skipping installing the optionals"
fi

chown $SUDO_USER run_manually.sh
chmod 777 run_manually.sh

echo "all the steps have been completed. now, please execute run_manually.sh in a new shell, ideally after a restart."

exit 0
