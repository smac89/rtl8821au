#!/bin/bash

set -e

HEADERS=$(apt-cache search '^linux-headers-[0-9]\.[0-9]+\.0-[0-9]+.+generic$' --names-only | sort --version-sort --reverse | sed -r 's/(.+?) \- .*/\1/' | sort --field-separator='-' --ignore-case --unique --key=1,3)

IGNORED_HEADERS="$(cat <<'EOF'
EOF
)"

for linux_header in $HEADERS; do
    if ! [[ $IGNORED_HEADERS =~ "$linux_header" ]]; then
        apt --quiet install $linux_header --yes 1>&2
        echo "${linux_header//linux-headers-/}"
    fi
done >> "$INSTALLED_HEADERS"

echo -e "\n\nThe following headers were installed:\n$(cat $INSTALLED_HEADERS)"
