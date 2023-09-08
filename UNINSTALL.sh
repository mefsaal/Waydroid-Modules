#!/usr/bin/env bash

# First use dkms to remove the modules:
sudo dkms remove waydroid-binder/1

# Then remove the module sources from /usr/src/:
sudo rm -rf /usr/src/waydroid-binder-1

# Finally remove the configuration files:
sudo rm -f /etc/modules-load.d/waydroid.conf
sudo rm -f /lib/udev/rules.d/99-waydroid.rules

# Verify remove by trying to load the modules and checking the created devices:
if sudo modprobe binder_linux > /dev/null 2>&1; then
    failed_checks=1
else
    failed_checks=0
fi

if lsmod | grep -e binder_linux > /dev/null 2>&1; then
    failed_checks=1
else
    failed_checks=0
fi

if [ $failed_checks == 1 ]; then
    echo "Please restart your device and rerun this script to verify changes"
else
    echo "Modules not installed"
fi