#!/bin/bash

echo "##################################################"
echo "Realtek Wi-Fi driver Auto Uninstall Script"
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
    case "$name" in
        'PACKAGE_NAME') DRV_NAME="${value//\"/}" ;;
        'PACKAGE_VERSION') DRV_VERSION="${value//\"/}" ;;
        'DEST_MODULE_NAME[0]') DRV_MODNAME="${value//\"/}" ;;
        'BUILT_MODULE_NAME[0]') if [ -z DRV_MODNAME ]; then DRV_MODNAME="${value//\"/}"; fi ;;
    esac
done <<< "$(cat 'dkms.conf')"

if [[ -z "$DRV_NAME" || -z "$DRV_VERSION" || -z "$DRV_MODNAME" ]]; then
    echo 'Could not read module info from dkms.conf. Make sure it exists'
    exit 1
fi

IFS="${PREV_IFS}"

################################################################################
#            Uninstall the module
################################################################################
dkms remove -m ${DRV_NAME} -v ${DRV_VERSION} --all
modprobe -r ${DRV_MODNAME}

echo "##################################################"
echo -e "The Uninstall Script is \e[32mcompleted!\e[0m"
echo "##################################################"
