#!/bin/bash
set -euo pipefail

TEMP="${HOME}/tmp"
MEDIAWIKI_VERSION="1.45.4"
MEDIAWIKI_ARCH="mediawiki-${MEDIAWIKI_VERSION}.tar.gz"
MEDIAWIKI_URL="https://releases.wikimedia.org/mediawiki/1.45/${MEDIAWIKI_ARCH}"

DOCUMENT_ROOT="${1:?DOCUMENT_ROOT argument not provided}"

ARCHIVE="${TEMP}/${MEDIAWIKI_ARCH}"
STAGING="${TEMP}/mediawiki-${MEDIAWIKI_VERSION}"

mkdir -p "$TEMP"

# Remove any previous incomplete download/staging directory
rm -f "$ARCHIVE"
rm -rf "$STAGING"

printf 'Downloading MediaWiki %s...\n' "$MEDIAWIKI_VERSION"

curl \
    --fail \
    --location \
    --retry 10 \
    --retry-delay 2 \
    --retry-all-errors \
    --continue-at - \
    --output "$ARCHIVE" \
    "$MEDIAWIKI_URL"

# Extract to staging first
mkdir -p "$STAGING"

tar xzf "$ARCHIVE" -C "$STAGING" \
    --strip-components=1

# Basic sanity checks before touching Apache's DocumentRoot
test -f "$STAGING/index.php"
test -d "$STAGING/includes"
test -d "$STAGING/vendor"

printf 'Installing into %s...\n' "$DOCUMENT_ROOT"

sudo mkdir -p "$DOCUMENT_ROOT"

sudo cp -a "$STAGING"/. "$DOCUMENT_ROOT"/

rm -rf "$STAGING"
rm -f "$ARCHIVE"

printf 'MediaWiki %s installed successfully.\n' "$MEDIAWIKI_VERSION"
