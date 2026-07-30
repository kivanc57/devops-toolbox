#!/bin/bash
set -euo pipefail

source .env

: "${SV_USERNAME:?SV_USERNAME not set}"
: "${SV_IP:?SV_IP not set}"

SYNC_FOLDER="${HOME}"
DEST_FOLDER="backups/$(date +%Y-%m-%d)"
EXCLUDED="excluded.txt"

rsync -azP \
    --mkpath \
    --exclude-from="${EXCLUDED}" \
    --no-owner \
    --no-group \
    "${SYNC_FOLDER}/" \
    "${SV_USERNAME}@${SV_IP}:${DEST_FOLDER}/"

