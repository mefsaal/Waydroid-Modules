#!/usr/bin/env bash

# First install the configuration files:
sudo cp waydroid.conf /etc/modules-load.d/
sudo cp 99-waydroid.rules /lib/udev/rules.d/

# Then copy the module sources to /usr/src/:
sudo cp -rT binder /usr/src/waydroid-binder-1

# Finally use dkms to build and install:
sudo dkms install waydroid-binder/1

# Verify by loading these modules and checking the created devices:
sudo modprobe binder_linux
lsmod | grep -e binder_linux
ls -alh /dev/binder