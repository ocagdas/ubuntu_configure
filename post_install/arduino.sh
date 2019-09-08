#!/bin/sh

if [ `id -u` -ne '0' ]; then
	echo "EXIT[ERR]: need to run as root, exiting"
	exit -1
fi

installer_dl_link=$(echo "www.arduino.cc/download_handler.php?f=/arduino-1.8.9-linux64.tar.xz" | grep -Eo "www.arduino.*arduino-([0-9]{1,2}.){2}[0-9]{1,3}-linux64.tar.xz")
installer_pck="${installer_dl_link##*/}"
wget https://downloads.arduino.cc/$installer_pck

if [ -f $installer_pck ]; then
	chmod 755 $installer_pck
	echo "extracting..."
	sudo -u $SUDO_USER sh -c "tar xf $installer_pck --checkpoint=.100 -C ~/"
	rm $installer_pck
	installer_pck_basename=$(echo ${installer_pck%.*} | sed -r 's@(.*)-linux.*.tar.*@\1@')
	echo $installer_pck_basename
	cd ~/$installer_pck_basename
	sudo ./install.sh
	cd -
else
	echo "exit[fail]: cannot find $installer_pck"
	exit -1
fi

exit 0
