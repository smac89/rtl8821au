#!/bin/bash

echo "##################################################"
echo "Realtek Wi-Fi driver Auto Installation Script"
echo "November, 21 2011 v1.1.0"
echo "##################################################"

################################################################################
#			Check for root. Exit if not root
################################################################################
if ! [ $EUID = 0 ]; then
    echo -e "script should be run as \e[1;91mroot\e[0m!!"
    exit 1
fi

################################################################################
#			Read the module info from the dkms script
################################################################################
DRV_NAME=
DRV_VERSION=

PREV_IFS="${IFS}"
IFS='='
while read -r name value; do
    case "$name" in
        'PACKAGE_NAME') DRV_NAME="${value//\"/}" ;;
        'PACKAGE_VERSION') DRV_VERSION="${value//\"/}" ;;
    esac

    if ! [[ -z "$DRV_NAME" || -z "$DRV_VERSION" ]]; then
        break
    fi
done <<< "$(cat 'dkms.conf')"

if [[ -z "$DRV_NAME" || -z "$DRV_VERSION" ]]; then
    echo 'Could not read module info from dkms.conf. Make sure it exists'
    exit 1
fi

IFS="${PREV_IFS}"

################################################################################
#            Copy the driver sources to the /usr/src
################################################################################
mkdir -p /usr/src/"${DRV_NAME}-${DRV_VERSION}"
git archive driver-${DRV_VERSION} | tar -x -C /usr/src/"${DRV_NAME}-${DRV_VERSION}"

################################################################################
#			Start dkms
################################################################################
dkms add -m ${DRV_NAME} -v ${DRV_VERSION}
dkms build -m ${DRV_NAME} -v ${DRV_VERSION}
dkms install -m ${DRV_NAME} -v ${DRV_VERSION}
modprobe ${DRV_NAME}

echo "##################################################"
echo "The Install Script is \e[32mcompleted!"
echo "##################################################"
