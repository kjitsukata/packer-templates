#!/bin/bash

VAGRANT_USER='vagrant'
VAGRANT_GROUP='vagrant'
VAGRANT_HOME=/home/${VAGRANT_USER}
VAGRANT_KEY_URL='https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub'

# install packages
echo "APT update"
sudo apt update -y && sudo apt upgrade -y
echo "Installing Packages"
sudo apt install -y build-essential curl wget git perl debconf-utils zsh unzip libssl-dev dkms linux-image-amd64 linux-headers-`uname -r` sysstat linuxlogo

# configure sysstat
sudo sed -i -e 's/ENABLED="false"/ENABLED="true"/g' /etc/default/sysstat
sudo sed -i -e "s/^5-55\/10/5-55\/1/g" /etc/cron.d/sysstat
sudo sed -i -e "s/^HISTORY=7/HISTORY=31/g" /etc/sysstat/sysstat
sudo systemctl enable sysstat.service

# install vagrant keys
echo "Installing Vagrant User Keys"
mkdir -pm 700 ${VAGRANT_HOME}/.ssh
wget --no-check-certificate ${VAGRANT_KEY_URL} -O ${VAGRANT_HOME}/.ssh/authorized_keys
chmod 600 ${VAGRANT_HOME}/.ssh/authorized_keys
chown -R ${VAGRANT_USER}:${VAGRANT_GROUP} ${VAGRANT_HOME}/.ssh

# change shell for vagrant user
sudo /bin/chsh -s /bin/zsh vagrant

# install Oh-My-Zsh and Powerlevel10k for vagrant user
sudo -u vagrant sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo -u vagrant git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
