#!/bin/bash
set -euo pipefail

read -rp "abs folder location: " INPUT_DIR

log() { printf '\n[%s] %s\n' "$(date -Is)" "$*"; }

log "START: finding duplicates"

find "${INPUT_DIR}" -type f -readable -size +1M -print0 \
  | xargs -0 sha256sum \
  | sort \
  | uniq -w64 -d \

log "END: finding duplicates"

