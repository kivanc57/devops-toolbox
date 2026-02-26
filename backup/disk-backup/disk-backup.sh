#!/bin/bash
set -euo pipefail

SOURCE_DISK="/dev/nvme0n1p1"
BACKUP_FOLDER="${HOME}/backups"
BACKUP_ARCHIVE="${BACKUPS_DIR}/disk-$(date +%Y-%m-%d).img.gz"

mkdir -p "${BACKUP_FOLDER}"

dd if="${SOURCE_DISK}" bs=4M status=progress | gzip > "${BACKUP_ARCHIVE}"

