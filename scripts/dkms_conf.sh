DRV_NAME=
DRV_VERSION=
DRV_MODNAME=

while IFS='=' read -r name value; do
    clean_value="${value//\"/}"
    case "$name" in
        'PACKAGE_NAME') DRV_NAME="$clean_value" ;;
        'PACKAGE_VERSION') DRV_VERSION="$clean_value" ;;
        'DEST_MODULE_NAME[0]') DRV_MODNAME="$clean_value" ;;
        'BUILT_MODULE_NAME[0]') if [ -z "$DRV_MODNAME" ]; then DRV_MODNAME="$clean_value"; fi ;;
    esac
done < "$(dirname $(readlink -f $BASH_SOURCE))/../dkms.conf"
