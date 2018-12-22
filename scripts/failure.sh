#!/bin/bash

set -e

# DRV_NAME=
# DRV_VERSION=
source dkms_conf.sh

# Triggered when an error occurs

cat "/var/lib/dkms/$DRV_NAME/$DRV_VERSION/build.make.log"
