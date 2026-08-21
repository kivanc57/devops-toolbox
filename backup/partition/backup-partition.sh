#!/bin/bash
set -euo pipefail

source .env

: "${SV_USERNAME:?SV_USERNAME not set}"
: "${SV_IP:?SV_IP not set}"

INC_PARTS=(usr var)
EXC_PARTS="excluded.txt"
BACKUP_NAME="usr+var-$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

REMOTE="${SV_USERNAME}@${SV_IP}"

tar \
    --create \
    --gzip \
    --file=- \
    --one-file-system \
    --exclude-from="${EXC_PARTS}" \
    -C / \
    "${INC_PARTS[@]}" |
pv |
ssh "$REMOTE" \
    "mkdir -p \"\$HOME/backups\" && cat > \"\$HOME/backups/${BACKUP_NAME}\""

