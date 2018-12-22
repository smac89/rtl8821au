#!/bin/bash

DRV_NAME=
DRV_VERSION=

set -ev

while IFS='=' read -r name value; do
    clean_value="${value//\"/}"
    case "$name" in
        'PACKAGE_NAME') DRV_NAME="$clean_value" ;;
        'PACKAGE_VERSION') DRV_VERSION="$clean_value" ;;
    esac
done <<< "$(cat dkms.conf)"

dkms status --all
dkms install "${DRV_NAME}/${DRV_VERSION}" --all
