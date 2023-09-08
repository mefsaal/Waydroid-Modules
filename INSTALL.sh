#!/usr/bin/env bash

# Important: The script should check if DKMS is Present, because its important so no one would cry at issues
CHECK=$(command -v dkms 2>/dev/null)
if [ -n "$CHECK" ]
  then 
  echo "DKMS Present, Istalling Waydroid Modules"
  else
  echo "DKMS Did not respond, it seems that DKMS is not Present or you are not running in sudo/root mode"
  echo "To make sure, please install dkms and try running the script again with sudo"
  exit 1
fi
unset CHECK

# Start the Operation! : install the configuration files:
sudo cp waydroid.conf /etc/modules-load.d/
sudo cp 99-waydroid.rules /lib/udev/rules.d/

# Then copy the module sources to /usr/src/:
sudo cp -rT binder /usr/src/waydroid-binder

# Finally use dkms to build and install:
sudo dkms install waydroid-binder/1

# Verify by loading these modules and checking the created devices:
sudo modprobe binder_linux
lsmod | grep -e binder_linux
ls -alh /dev/binder