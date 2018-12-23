#!/bin/bash

set -e

for linux_header in "$(cat $INSTALLED_HEADERS)"; do
    dkms status -k "$linux_header"

    dkms add "${DRV_NAME}/${DRV_VERSION}" -k "$linux_header"
    dkms build "${DRV_NAME}/${DRV_VERSION}" -k "$linux_header"
    dkms install "${DRV_NAME}/${DRV_VERSION}" -k "$linux_header"
done
