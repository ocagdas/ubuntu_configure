#!/bin/sh

if [ `id -u` -ne '0' ]; then
	echo "EXIT[ERR]: need to run as root, exiting"
	exit -1
fi

./graphics_card.sh
./gnome_desktop.sh
./chrome.sh

echo "pre-graph steps are completed. please restart your pc and continue with the post-graph setup"
# let's enforce a reboot until the nvidia graphics driver console log spamming issue is resolved
sync && reboot -f

exit 0
