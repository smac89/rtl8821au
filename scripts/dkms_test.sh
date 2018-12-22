#!/bin/bash

set -e

DRV_NAME=
DRV_VERSION=

PREV_IFS="${IFS}"
IFS='='
while read -r name value; do
    clean_value="${value//\"/}"
    case "$name" in
        'PACKAGE_NAME') DRV_NAME="$clean_value" ;;
        'PACKAGE_VERSION') DRV_VERSION="$clean_value" ;;
    esac
done <<< "$(cat dkms.conf)"

IFS="${PREV_IFS}"

dkms status --all
dkms install "${DRV_NAME}/${DRV_VERSION}" --all

set +e
