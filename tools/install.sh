#!/bin/bash

id=`id -u`
if [ $id = "0" ]
then
        sudo -u vagrant $0
fi

sudo apt-get update
sudo apt-get -y install git ansible isc-dhcp-server
sudo cp /vagrant/tools/dhcpd.conf /etc/dhcp

cd ~
if [ ! -d rackhd ]; then
  git clone https://github.com/rackhd/rackhd
else
  cd ~/rackhd
  git pull origin master
fi


cd ~vagrant/rackhd/packer/ansible
ansible-playbook -i "local," -c local rackhd_local.yml

sudo cp /vagrant/tools/monorail-config.json /opt/monorail/config.json

echo "rackhd installed!"
echo "to start it, simply run /vagrant/tools/start.sh from within the vm"
echo ""
