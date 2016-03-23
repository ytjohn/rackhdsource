#!/bin/bash

if [ $id = "0" ]
then
        sudo -u vagrant $0
fi

cd ~
sudo nf start
