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

# installing packages
echo "Installing Packages"
sudo yum install -y gcc make perl kernel-headers-`uname -r` kernel-devel-`uname -r` wget
sudo yum groupinstall -y 'Development tools'

# installing dkms packages from epel
sudo sh -c 'echo "[epel]" >> /etc/yum.repos.d/epel.repo'
sudo sh -c 'echo "name=EPEL Packages for Enterprise Linux 6 - \$basearch" >> /etc/yum.repos.d/epel.repo'
sudo sh -c 'echo "baseurl=http://dl.fedoraproject.org/pub/epel/6/\$basearch" >> /etc/yum.repos.d/epel.repo'
sudo sh -c 'echo "enabled=0" >> /etc/yum.repos.d/epel.repo'
sudo sh -c 'echo "gpgcheck=0" >> /etc/yum.repos.d/epel.repo'
sudo yum --enablerepo=epel install -y dkms
sudo rm /etc/yum.repos.d/epel.repo

# installing vagrant keys
echo "Installing Vagrant User Keys"
mkdir -pm 700 ${VAGRANT_HOME}/.ssh
wget --no-check-certificate ${VAGRANT_KEY_URL} -O ${VAGRANT_HOME}/.ssh/authorized_keys
chmod 600 ${VAGRANT_HOME}/.ssh/authorized_keys
chown -R ${VAGRANT_USER}:${VAGRANT_GROUP} ${VAGRANT_HOME}/.ssh

