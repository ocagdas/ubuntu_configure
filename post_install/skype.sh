#!/bin/sh

if [ `id -u` -ne '0' ]; then
    echo "EXIT[ERR]: need to run as root, exiting"
    exit -1
fi

wget https://repo.skype.com/latest/skypeforlinux-64.deb
sudo gdebi --non-interactive skypeforlinux-64.deb
rm -f skypeforlinux-64.deb

