#!/bin/bash

sudo rm /var/lib/dhcpd.leases
echo "db.dropDatabase()" | mongo pxe

sudo service-isc-dhcp server start
