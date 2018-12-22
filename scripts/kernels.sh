#!/bin/bash

if ! $TRAVIS_SUDO; then
    echo "Need root"
    exit 1
fi

HEADERS=$(sudo apt-cache search '^linux-headers-[0-9]\.[0-9]+\.0-[0-9]+.+generic$' --names-only | sed -E 's/(.+?) \- .*/\1/')

for linux_header in $HEADERS; do
    sudo apt install $linux_header -y
done
