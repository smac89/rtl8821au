#!/bin/bash

if ! $TRAVIS_SUDO; then
    echo "Need root"
    exit 1
fi

HEADERS=$(sudo apt-cache search '^linux-image-[0-9]\.[0-9]+\.0-[0-9]+.+generic$' --names-only | sort --version-sort --reverse | sed -r 's/(.+?) \- .*/\1/' | sort --field-separator='-' --ignore-case --unique --key=1,3)

for linux_header in $HEADERS; do
    sudo apt install $linux_header -y
done
