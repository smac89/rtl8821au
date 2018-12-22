#!/bin/bash

DRV_NAME=
DRV_VERSION=

set -e

while IFS='=' read -r name value; do
    clean_value="${value//\"/}"
    case "$name" in
        'PACKAGE_NAME') DRV_NAME="$clean_value" ;;
        'PACKAGE_VERSION') DRV_VERSION="$clean_value" ;;
    esac
done < 'dkms.conf'

for linux_header in "$(cat $INSTALLED_HEADERS)"; do
    dkms status -k "$linux_header"

    dkms add "${DRV_NAME}/${DRV_VERSION}" -k "$linux_header"
    dkms build "${DRV_NAME}/${DRV_VERSION}" -k "$linux_header"
    dkms install "${DRV_NAME}/${DRV_VERSION}" -k "$linux_header"
done
