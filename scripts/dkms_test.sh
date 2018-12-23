#!/bin/bash

set -e

echo "${DRV_NAME}/${DRV_VERSION}"

for linux_header in "$(cat $INSTALLED_HEADERS)"; do
    dkms status -k "$linux_header"

    dkms add -m "${DRV_NAME}/${DRV_VERSION}" -k "$linux_header"
    dkms build -m "${DRV_NAME}/${DRV_VERSION}" -k "$linux_header"
    dkms install -m "${DRV_NAME}/${DRV_VERSION}" -k "$linux_header"
done
