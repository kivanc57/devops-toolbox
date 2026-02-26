#!/bin/bash
set -euo pipefail

source .env

: "${SV_USERNAME:?SV_USERNAME not set}"
: "${SV_IP:?SV_IP not set}"

export SV_USERNAME
export SV_IP

BACKUP_FOLDER="${HOME}/backups"
SYNC_FOLDER=${HOME}
DEST_FOLDER="${BACKUP_FOLDER}/${SYNC_FOLDER}-$(date +%Y-%m-%d)"
EXCLUDED="excluded.txt"

mkdir -p "${BACKUP_FOLDER}"

rsync -azP --delete --exclude-from="${EXCLUDED}" \
    --no-owner --no-group --ignore-errors \
    "${SYNC_FOLDER}" "${SV_USERNAME}@${SV_IP}:${DEST_FOLDER}"

