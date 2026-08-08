#!/bin/bash
set -euo pipefail

SOURCE_DISK="/dev/nvme0n1p1"
BACKUP_PATH="${HOME}/backups"
BACKUP_ARCHIVE="${BACKUP_PATH}/disk-$(date +%Y-%m-%d).img.gz"

mkdir -p "${BACKUP_PATH}"

sudo dd if="${SOURCE_DISK}" bs=4M status=progress | gzip > "${BACKUP_ARCHIVE}"

