#!/bin/bash

# Ensure we are being run as root
if [ $(id -u) -ne 0 ]; then
	echo "This script must be ran as root"
	exit 1
fi

while true; do
    read -p "Continue with installation? (Y/n) " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) break;;
    esac
done

# i2p Stuff :( // feels like bloat to me, as I have no use for it, but program breaks w/o it sooo

rm -r /etc/apt/sources.list.d/i2p.list
rm -r /usr/share/keyrings/i2p-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/i2p-archive-keyring.gpg] https://deb.i2p2.de/ unstable main" \
  | sudo tee /etc/apt/sources.list.d/i2p.list

wget -O- http://geti2p.net/_static/i2p-debian-repo.key.asc | gpg --dearmor | sudo tee /usr/share/keyrings/i2p-archive-keyring.gpg


if [[ -n $(cat /etc/os-release | grep kali) ]]
then
	apt install libservlet3.0-java 
	wget http://ftp.us.debian.org/debian/pool/main/j/jetty8/libjetty8-java_8.1.16-4_all.deb
	dpkg -i libjetty8-java_8.1.16-4_all.deb
	apt install libecj-java libgetopt-java libservlet3.0-java glassfish-javaee ttf-dejavu libjbigi-jni i2p i2p-router
	apt -f install
fi

apt install -y i2p-keyring
apt install -y secure-delete tor
apt autoremove -y
apt update -y

dpkg-deb -b kali-anonsurf-deb-src/ kali-anonsurf.deb
dpkg -i kali-anonsurf.deb || (apt -f install && dpkg -i kali-anonsurf.deb)

exit
