#!/bin/sh

if [ `id -u` -ne '0' ]; then
	echo "EXIT[ERR]: need to run as root, exiting"
	exit -1
fi

read -p "Enter username for new admin, leave empty to skip: "  admin_username
if [ `echo $admin_username | wc -m` -gt '4' ]; then
	adduser --disabled-password --gecos "" $admin_username
	usermod -aG sudo $admin_username

	echo "created admin user $admin_username without password."
	echo "after reboot, login as $admin_username and run the /home/$admin_username/first_boot.sh script"
	echo "sudo passwd $admin_username" > /home/$admin_username/first_boot.sh
	echo "sudo userdel -rf $USER > /dev/null 2>&1" >> /home/$admin_username/first_boot.sh
	chmod 755 /home/$admin_username/first_boot.sh

	read -n 1 -s -r -p "Press enter to continue..."
	echo ""
else
	admin_username=$SUDO_USER
fi

echo "current hostname: " `hostname`
read -p "Enter new hostname, leave empty to skip: "  hostname_new
if [ `echo $hostname_new | wc -m` -gt '4' ]; then
	hostnamectl set-hostname $hostname_new
	echo "new hostname: " `hostname`
fi

# point /bin/sh to bash
ln -sf /bin/bash /bin/sh

sudo ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime

sudo add-apt-repository -y ppa:mkusb/ppa
sudo add-apt-repository -y ppa:gezakovacs/ppa

sudo apt-get update && apt-get -y upgrade
sudo DEBIAN_FRONTEND=noninteractive apt install -y curl \
	lsb-core \
	ubuntu-drivers-common \
	gdebi-core \
	unetbootin \
	figlet \
	pdfgrep \
	ssh sshfs cifs-utils \
	openvpn resolvconf \
	git mercurial \
	doxygen \
	clang \
	default-jdk default-jre \
	pm-utils \
	gigolo \
	python3 python3-pip \
	python3-bandit \
	pv \
	minicom microcom \
	gconf2 \
	gnuplot \
	zlib1g-dev \
	genisoimage \
	isolinux \
	parted util-linux e2fsprogs \
	xorriso dumpet squashfs-tools \
	qemu qemu-kvm ovmf \
	traceroute \
	node.js npm \
	libnl-3-dev libnl-genl-3-dev libnl-nf-3-dev libnl-route-3-dev \
	dos2unix parallel \
	ruby-full

snap install pdftk

npm i -g bash-language-server

sudo DEBIAN_FRONTEND=noninteractive apt install --install-recommends -y \
	mkusb mkusb-nox usb-pack-efi

sudo -u $admin_username pip3 install cpplint
sudo ln -sf /home/$admin_username/.local/bin/cpplint /usr/bin/cpplint

sudo -u $admin_username pip3 install jira urllib3 beautifulsoup4 lxml
sudo -u $admin_username pip3 install pylint
sudo ln -sf /home/$admin_username/.local/bin/pylint /usr/bin/pylint

# install ruby version manager
#curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
#curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -

#curl -sSL https://get.rvm.io -o rvm.sh
#cat rvm.sh | bash -s stable

#rvm install ruby --disable-binary
#rm -f rvm.sh

gem install nokogiri

ruby -v
exit 0
