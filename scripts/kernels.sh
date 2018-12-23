#!/bin/bash

set -e

AVAILABLE_HEADERS=$(apt-cache search '^linux-headers-[0-9]+\.[0-9]+\.[0-9]+\-[0-9]+.+generic$' --names-only | sort --version-sort --reverse | sed -r 's/(.+?) \- .*/\1/' | sort --field-separator='-' --ignore-case --unique --key=1,3)

KERNEL_ADDITIONAL_VERSIONS="$(cat <<'EOF'
EOF
)"

KERNEL_IGNORED_VERSIONS="$(cat <<'EOF'
EOF
)"

for linux_header in $AVAILABLE_HEADERS; do
    header_version="${linux_header//linux-headers-/}"
    if ! [[ "${KERNEL_IGNORED_VERSIONS[@]}" =~ "$header_version" ]]; then
        apt --quiet install $linux_header --yes 1>&2
        echo "$header_version"
    fi
done >> "$INSTALLED_HEADERS"

echo -e "\n\nThe following headers were installed:\n$(cat $INSTALLED_HEADERS)"
