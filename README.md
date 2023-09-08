[![Build Status](https://travis-ci.org/anbox/anbox-modules.svg?branch=master)](https://travis-ci.org/anbox/anbox-modules)

# Anbox Kernel Modules

This repository contains the kernel modules necessary to run the Anbox
Android container runtime. They're split out of the original Anbox
repository to make packaging in various Linux distributions easier.

# Install Instruction

You need to have `dkms` and linux-headers on your system. You can install them by
`sudo apt install dkms` or `sudo yum install dkms` (`dkms` is available in epel repo
for CentOS).

Package name for linux-headers varies on different distributions, e.g.
`linux-headers-generic` (Ubuntu), `linux-headers-amd64` (Debian),
`kernel-devel` (CentOS, Fedora), `kernel-default-devel` (openSUSE).


You can either run `./INSTALL.sh` script to automate the installation steps or follow them manually below:

* First install the configuration files:

  ```
   sudo cp waydroid.conf /etc/modules-load.d/
   sudo cp 99-waydroid.rules /lib/udev/rules.d/
  ```

* Then copy the module sources to `/usr/src/`:

  ```
   sudo cp -rT binder /usr/src/anbox-binder-1
  ```

* Finally use `dkms` to build and install:

  ```
   sudo dkms install anbox-binder/1
  ```

You can verify by loading these modules and checking the created devices:

```
 sudo modprobe binder_linux
 lsmod | grep -e binder_linux
 ls -alh /dev/binder
```

You are expected to see output like:

```
binder_linux          114688  0
crw-rw-rw- 1 root root 511,  0 Jun 19 16:30 /dev/binder
```

# Uninstall Instructions

ou can either run `./UNINSTALL.sh` script to automate the installation steps or follow them manually below:

* First use dkms to remove the modules:

  ```
   sudo dkms remove anbox-binder/1
  ```

* Then remove the module sources from /usr/src/:

  ```
   sudo rm -rf /usr/src/anbox-binder-1
  ```

* Finally remove the configuration files:

  ```
   sudo rm -f /etc/modules-load.d/waydroid.conf
   sudo rm -f /lib/udev/rules.d/99-waydroid.rules 
  ```

You must then restart your device. You can then verify modules were removed by trying to load the modules and checking the created devices:

```
 sudo modprobe binder_linux
 lsmod | grep -e binder_linux
 ls -alh /dev/binder
```

You are expected to see output like:

```
modprobe: FATAL: Module binder_linux not found in directory /lib/modules/6.0.2-76060002-generic
ls: cannot access '/dev/binder': No such file or directory
```
