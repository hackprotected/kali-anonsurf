#!/bin/bash

# Ensure we are being run as root
if [ $(id -u) -ne 0 ]; then
	echo "This script must be ran as root"
	exit 1
fi

if [[ -n $(cat /etc/os-release |grep kali) ]]
then
	apt install libservlet3.0-java 
	wget http://ftp.us.debian.org/debian/pool/main/j/jetty8/libjetty8-java_8.1.16-4_all.deb
	dpkg -i libjetty8-java_8.1.16-4_all.deb
	apt install libecj-java libgetopt-java libservlet3.0-java glassfish-javaee ttf-dejavu libjbigi-jni
	apt -f install
fi

apt install -y secure-delete tor

dpkg-deb -b kali-anonsurf-deb-src/ kali-anonsurf.deb
dpkg -i kali-anonsurf.deb || (apt -f install && dpkg -i kali-anonsurf.deb)

exit
