#!/bin/bash
set -euo pipefail

TEMP="${HOME}/tmp"
NEXTCLOUD_VERSION="34.0.2"
NEXTCLOUD_ARCH="nextcloud-${NEXTCLOUD_VERSION}.tar.bz2"
NEXTCLOUD_URL="https://download.nextcloud.com/server/releases/${NEXTCLOUD_ARCH}" 

DOCUMENT_ROOT="${1:?DOCUMENT_ROOT argument not provided}"

ARCHIVE="${TEMP}/${NEXTCLOUD_ARCH}"
STAGING="${TEMP}/nextcloud-${NEXTCLOUD_VERSION}"

mkdir -p "$TEMP"

rm -rf "$STAGING"

printf 'Downloading Nextcloud %s...\n' "${NEXTCLOUD_VERSION}"

curl \
    --fail \
    --location \
    --retry 10 \
    --retry-delay 2 \
    --retry-all-errors \
    --continue-at - \
    --output "${ARCHIVE}" \
    "${NEXTCLOUD_URL}"

printf 'Validating archive...\n'

bzip2 -t "$ARCHIVE"
tar tf "$ARCHIVE" >/dev/null

printf 'Extracting to staging...\n'

mkdir -p "$STAGING"

tar xf "$ARCHIVE" \
    -C "$STAGING" \
    --strip-components=1

# Sanity checks
test -f "$STAGING/index.php"
test -d "$STAGING/core"
test -d "$STAGING/lib"

printf 'Installing into %s...\n' "$DOCUMENT_ROOT"

sudo mkdir -p "$DOCUMENT_ROOT"
sudo cp -a "$STAGING"/. "$DOCUMENT_ROOT"/

rm -rf "$STAGING"
rm -f "$ARCHIVE"

printf 'MediaWiki %s installed successfully.\n' "${NEXTCLOUD_VERSION}"

