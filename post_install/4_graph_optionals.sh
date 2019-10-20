#!/bin/sh

if [ `id -u` -ne '0' ]; then
	echo "EXIT[ERR]: need to run as root, exiting"
	exit -1
fi

sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"

apt-get update
apt -y upgrade

DEBIAN_FRONTEND=noninteractive apt install -y \
	synergy \
	gimp \
	vlc browser-plugin-vlc \
	simplescreenrecorder \
	libdvdnav4 libdvdread4 gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly libdvd-pkg \
	ubuntu-restricted-extras \
	adobe-flashplugin browser-plugin-freshplayer-pepperflash

sudo snap install cool-retro-term --classic

dpkg-reconfigure libdvd-pkg

echo ""
echo "checking the latest version of franz"
franz_base_url="https://github.com"
franz_rels_url="${franz_base_url}""/meetfranz/franz/releases/"
franz_latest_deb=$(curl -s ${franz_rels_url} | grep -Eo "franz_[0-9]{1}\.[0-9]{1,3}\.[0-9]{1,3}_amd64.deb" | sort -V | uniq | tail -n1)
franz_ver=$(echo ${franz_latest_deb} |  sed -r 's@.*_(.*)_.*@\1@')
fran_dl_url="${franz_rels_url}""download/v""${franz_ver}""/${franz_latest_deb}"
echo "attempting to download $franz_latest_deb"
wget ${fran_dl_url}
if [ "$?" -eq '0' ]; then
	sha256sum ${franz_latest_deb}
	dpkg -i ${franz_latest_deb}
	rm ${franz_latest_deb} -f
fi

cd /home/$SUDO_USER
PYLOTE_TAR_FILE="pylote.tar.gz"
wget http://pascal.peter.free.fr/wikiuploads/$PYLOTE_TAR_FILE
if [ -f "$PYLOTE_TAR_FILE" ]; then
	tar xzf pylote.tar.gz
	chmod 755 pylote*
	chown $SUDO_USER:$SUDO_USER pylote* -R
	rm -f $PYLOTE_TAR_FILE
fi

apt purge ttf-mscorefonts-installer
TTF_DEB_FILE="ttf-mscorefonts-installer_3.7_all.deb"
wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/$TTF_DEB_FILE
if [ -f "$TTF_DEB_FILE" ]; then
	apt install $PWD/$TTF_DEB_FILE
	rm -f $TTF_DEB_FILE
fi

apt autoremove -y
