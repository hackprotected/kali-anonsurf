#!/bin/bash

# Ensure we are being run as root
if [ $(id -u) -ne 0 ]; then
	echo "This script must be run as root"
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

git clone https://github.com/hackprotected/kali-anonsurf/ ~/./Kali-Anonsurf
cd ~/Kali-Anonsurf/
sudo sh installer.sh

exit0
