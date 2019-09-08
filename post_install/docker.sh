#!/bin/sh

if [ `id -u` -ne '0' ]; then
	echo "EXIT[ERR]: need to run as root, exiting"
	exit -1
fi

sudo apt-get update

sudo DEBIAN_FRONTEND=noninteractive apt-get remove -y docker docker-engine docker-compose docker.io containerd runc

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo systemctl status docker --no-pager

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce docker-ce-cli containerd.io
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y docker-compose
sudo DEBIAN_FRONTEND=noninteractive apt autoremove -y

sudo groupadd docker
sudo usermod -aG docker `getent group sudo | awk -F: '{print $4}'`
sudo systemctl start docker
sudo systemctl status docker --no-pager

docker run hello-world

exit 0
