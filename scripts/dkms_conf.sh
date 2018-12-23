DRV_NAME=
DRV_VERSION=

while IFS='=' read -r name value; do
    clean_value="${value//\"/}"
    case "$name" in
        'PACKAGE_NAME') DRV_NAME="$clean_value" ;;
        'PACKAGE_VERSION') DRV_VERSION="$clean_value" ;;
    esac
done < "${1-$(cat)}" # filename from argument or read from stdin

if ! [ -z "DRV_NAME" ]; then
    export DRV_NAME
else
    echo "DRV_NAME is not set" 1>&2
fi

if ! [ -z "DRV_VERSION" ]; then
    export DRV_VERSION
else
    echo "DRV_VERSION is not set" 1>&2
fi
