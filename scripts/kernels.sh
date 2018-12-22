#!/bin/bash

set -x

HEADERS=$(apt-cache search '^linux-image-[0-9]\.[0-9]+\.0-[0-9]+.+generic$' --names-only | sort --version-sort --reverse | sed -r 's/(.+?) \- .*/\1/' | sort --field-separator='-' --ignore-case --unique --key=1,3)

for linux_header in $HEADERS; do
    apt install $linux_header --quiet -y
done

echo -e "The following headers were installed:\n${HEADERS}"

set +x
