#!/bin/bash

# Ubuntu 13.10 only

# Virtualbox
apt-get remove virtualbox
echo "deb http://download.virtualbox.org/virtualbox/debian saucy contrib" >> /etc/apt/sources.list
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
apt-get update
apt-get install virtualbox-4.3

# Vagrant
apt-get remove vagrant
wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.4.3_x86_64.deb
dpkg -i vagrant_1.4.3_x86_64.deb
vagrant plugin install --plugin-source https://rubygems.org/ --plugin-prerelease vagrant-vbguest
rm vagrant_1.4.3_x86_64.deb