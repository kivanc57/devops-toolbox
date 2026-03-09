#!/bin/bash
set -euo pipefail

sudo apt-get update
sudo apt-get install bzip2 -y

TEMP="${HOME}/tmp"
NEXTCLOUD_ARCH="nextcloud-32.0.5.tar.bz2"
SERVER_ROOT=$(awk '/DocumentRoot/ {print $2}' /etc/apache2/sites-available/000-default.conf)

sudo mkdir -p "${TEMP}"

wget "https://download.nextcloud.com/server/releases/${NEXTCLOUD_ARCH}" -O \
    "${TEMP}/${NEXTCLOUD_ARCH}"

sudo tar xvf "${TEMP}/${NEXTCLOUD_ARCH}" -C "${SERVER_ROOT}"

sudo chown -R www-data:www-data "${SERVER_ROOT}/nextcloud"

sudo systemctl restart apache2

rm -f "${TEMP}/${NEXTCLOUD_ARCH}"

