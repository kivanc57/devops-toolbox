#!/bin/bash
set -euo pipefail

log() { printf '\n[%s] %s\n' "$(date -Is)" "$*"; }

rm -rf --one-file-system "$HOME/.cache/"*

rm -rf --one-file-system "$HOME/.config/google-chrome/Default/Cache/"*
rm -rf ~/.cache/google-chrome/Default/'Code Cache'

rm -rf --one-file-system "$HOME/.config/chromeium/Default/Cache/"*

sudo find /tmp -mindepth 1 -atime +7 -delete

log "Cleaned cache ..."

