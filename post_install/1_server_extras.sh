#!/bin/sh

if [ `id -u` -ne '0' ]; then
	echo "EXIT[ERR]: need to run as root, exiting"
	exit -1
fi

echo '#!/bin/sh' > run_manually.sh
echo "sudo sed -ri 's@^#WaylandEnable@WaylandEnable@' /etc/gdm3/custom.conf > /dev/null 2>&1" >> run_manually.sh
echo "sudo sed -ri 's@\"quiet\"@\"\"@' /etc/default/grub > /dev/null 2>&1" >> run_manually.sh
echo "sudo update-grub" >> run_manually.sh

./general.sh
./disk_man.sh
./solarize.sh
./docker.sh
./groups.sh
./virtualbox.sh
./vagrant.sh
./libvirt_kvm.sh
./vagrant_plugins.sh

apt-get purge ".*:i386" -y
dpkg --remove-architecture i386

echo "server extras are completed. please restart your pc and continue with the pre-graph setup"

exit 0
