#!/bin/bash

VAGRANT_USER='vagrant'
VAGRANT_GROUP='vagrant'
VAGRANT_HOME=/home/${VAGRANT_USER}
VAGRANT_KEY_URL='https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub'

# configure sudoer
echo "Configure sudo"
sudo sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# configure selinux
echo "Disable SELinux"
sudo /usr/sbin/setenforce 0
sudo sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config

# updating & installing packages
echo "Updating Packages"
sudo yum clean all
sudo yum check-update
sudo yum update -y
echo "Installing Packages"
sudo yum install -y gcc make perl kernel-headers kernel-devel curl wget git epel-release
sudo yum groupinstall -y 'Development tools'

# installing packages from epel
sudo yum clean all
sudo yum --enablerepo=epel install -y dkms

# installing vagrant keys
echo "Installing Vagrant User Keys"
mkdir -pm 700 ${VAGRANT_HOME}/.ssh
wget --no-check-certificate ${VAGRANT_KEY_URL} -O ${VAGRANT_HOME}/.ssh/authorized_keys
chmod 600 ${VAGRANT_HOME}/.ssh/authorized_keys
chown -R ${VAGRANT_USER}:${VAGRANT_GROUP} ${VAGRANT_HOME}/.ssh
