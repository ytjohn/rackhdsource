#!/bin/bash

id=`id -u`
if [ $id = "0" ]
then
        sudo -u vagrant $0
fi

cd ~vagrant/src
./scripts/clean_all.bash
./scripts/reset_submodules.bash
./scripts/link_install_locally.bash
