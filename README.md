# rtl8821AU

### This repository contains drivers for `RTL8821au`.

#### Supports kernel versions
- `>= 4.12` - only tested `4.13`, *but should theoretically work for as early as **2.4***

#### Compiled successfully on
- Ubuntu 16.04/4.13.0-39-generic

#### Thanks to
- [diederikdehaas](https://github.com/diederikdehaas) for the changes necessary for compiling on kernel versions greater than 4.12.

  See his [rtl8812au](https://github.com/diederikdehaas/rtl8812AU) repo
- [masterzorag](https://github.com/masterzorag/RTL8192EU-linux/pull/4/commits/6833e247c0b5f32b736c30c8935ef9a709544bc4)'s PR for pointing me in the right direction

#### Useful links
- [How to build a kernel module](http://xmodulo.com/build-kernel-module-dkms-linux.html)
- [Generate a deb for the driver](https://wiki.kubuntu.org/Kernel/Dev/DKMSPackaging#Generate_DKMS_deb)
