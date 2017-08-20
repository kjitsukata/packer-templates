#!/bin/bash

VAGRANT_USER=vagrant
VAGRANT_HOME=/home/${VAGRANT_USER}

# installing virtualbox guest additions
echo "Installing VirtualBox Guest Additions"

VBOX_VERSION=$(cat ${VAGRANT_HOME}/.vbox_version)
sudo mount -t iso9660 -o loop ${VAGRANT_HOME}/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sudo sh /mnt/VBoxLinuxAdditions.run
sudo umount /mnt
sudo /etc/rc.d/init.d/vboxadd setup
rm ${VAGRANT_HOME}/VBoxGuestAdditions_$VBOX_VERSION.iso

