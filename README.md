rackhdsource
============

RackHD from Source

This Vagrantfile will install RackHD from the latest source. 

All commands are expected to operate from within the rackhdsrc01 vagrant instance.

  - tools/install.sh - This is called by vagrant provision to install RackHD
  - tools/update.sh  - This will update to the most recent checked in code.
  - tools/reset.sh - this will delete the dhcpd.leases and the mongo database.
  - tools/start.sh - this will start rackhd (as a foreground process, logging to console).
  
If things go really wrong for you, either destroy the vm or destroy ~vagrant/src and ~vagrant/rackhd directories. Then you can re-run
the install script.

pxe boot vms
------------

Two vms (pxe01, pxe02) are defined with a known mac address and system serial number. You 
can start these up individually and watch rackhd provision them.



