#!/bin/bash

set -e

echo "##################################################"
echo "Realtek Wi-Fi driver Auto Installation Script"
echo "November, 21 2011 v1.1.0"
echo "##################################################"

################################################################################
#			Check for root. Exit if not root
################################################################################
if ! [ $EUID = 0 ]; then
    echo -e "\nScript should be run as \e[1;91mroot\e[0m!!"
    exit 1
fi

################################################################################
#			Read the module info from the dkms script
################################################################################
DRV_NAME=
DRV_VERSION=
DRV_MODNAME=

PREV_IFS="${IFS}"
IFS='='
while read -r name value; do
    clean_value="${value//\"/}"
    case "$name" in
        'PACKAGE_NAME') DRV_NAME="$clean_value" ;;
        'PACKAGE_VERSION') DRV_VERSION="$clean_value" ;;
        'DEST_MODULE_NAME[0]') DRV_MODNAME="$clean_value" ;;
        'BUILT_MODULE_NAME[0]') if [ -z "$DRV_MODNAME" ]; then DRV_MODNAME="$clean_value"; fi ;;
    esac
done <<< "$(cat 'dkms.conf')"

if [[ -z "$DRV_NAME" || -z "$DRV_VERSION" || -z "$DRV_MODNAME" ]]; then
    echo 'Could not read module info from dkms.conf. Make sure it exists'
    exit 1
fi

IFS="${PREV_IFS}"

################################################################################
#            Copy the driver sources to the /usr/src
################################################################################
echo -e "Archiving the current repository"

mkdir -p /usr/src/"${DRV_NAME}-${DRV_VERSION}"
git archive --format=tar.gz --worktree-attributes --verbose HEAD | tar -xz -C /usr/src/"${DRV_NAME}-${DRV_VERSION}"

################################################################################
#			Start dkms
################################################################################
dkms add -m ${DRV_NAME} -v ${DRV_VERSION} -k $(uname -r)
dkms build -m ${DRV_NAME} -v ${DRV_VERSION} -k $(uname -r)
dkms install -m ${DRV_NAME} -v ${DRV_VERSION} -k $(uname -r)
modprobe ${DRV_MODNAME} --verbose -S $(uname -r)

echo "##################################################"
echo -e "The Install Script is \e[32mcompleted!\e[0m"
echo "##################################################"

set +e
