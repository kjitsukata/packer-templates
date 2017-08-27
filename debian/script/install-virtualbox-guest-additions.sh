#!/bin/bash

VAGRANT_USER=vagrant
VAGRANT_HOME=/home/${VAGRANT_USER}

# installing virtualbox guest additions
echo "Installing VirtualBox Guest Additions"

sudo apt-get purge -y virtualbox-guest-utils
sudo apt-get autoremove -y

VBOX_VERSION=$(cat ${VAGRANT_HOME}/.vbox_version)
sudo mount -t iso9660 -o loop ${VAGRANT_HOME}/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sudo sh /mnt/VBoxLinuxAdditions.run
sudo umount /mnt
rm ${VAGRANT_HOME}/VBoxGuestAdditions_$VBOX_VERSION.iso

