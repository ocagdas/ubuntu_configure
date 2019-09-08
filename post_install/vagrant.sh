#!/bin/sh

if [ `id -u` -ne '0' ]; then
	echo "EXIT[ERR]: need to run as root, exiting"
	exit -1
fi

vagrant_url="https://www.vagrantup.com/downloads.html"
vagrant_dir="vagrant_dl"

mkdir -p $vagrant_dir && cd $vagrant_dir
rm -rf *
wget $vagrant_url
host_arch=`uname -i`
vagrant_deb=`grep "${host_arch}.deb" downloads.html | sed 's/.*="\(.*\)".*/\1/'`
wget ${vagrant_deb}

sudo dpkg -i *.deb
sudo apt-get install -f

vagrant --version

cd ..
rm -rf $vagrant_dir

exit 0
