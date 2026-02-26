#!/bin/bash
set -euo pipefail

source .env

: "${SV_USERNAME:?SV_USERNAME not set}"
: "${SV_IP:?SV_IP not set}"

export SV_USERNAME
export SV_IP

INC_PARTS="/usr /var"
EXC_PARTS="excluded.txt"
BACKUP_FOLDER="${HOME}/backups"
BACKUP_FILE="${DEST_FOLDER}/usr+var-$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

mkdir -p "${BACKUP_FOLDER}"

tar czf - --one-file-system / "${INC_PARTS}" \
--exclude-from="${EXC_PARTS}" |
pv | \
ssh "${SV_USERNAME}@${SV_IP}" > 'cat > "${BACKUP_FOLDER}"'

