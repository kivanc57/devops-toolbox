#!/bin/bash
set -euo pipefail

TEMP="${HOME}/tmp"
MEDIAWIKI_ARCH="mediawiki-1.45.1.tar.gz"
SERVER_ROOT=$(awk '/DocumentRoot/ {print $2}' /etc/apache2/sites-available/000-default.conf)

mkdir -p "${TEMP}"

wget "https://releases.wikimedia.org/mediawiki/1.45/${MEDIAWIKI_ARCH}" -O \
    "${TEMP}/${MEDIAWIKI_ARCH}"

sudo tar xvf "${TEMP}/${MEDIAWIKI_ARCH}" -C "${SERVER_ROOT}" \
    --strip-components=1

sudo chown -R www-data:www-data "${SERVER_ROOT}"

sudo systemctl restart apache2

rm -f "${TEMP}/${MEDIAWIKI_ARCH}"

