#!/bin/bash
set -euo pipefail

IMAGE="${HOME}/Downloads/proxmox-ve_8.4-1.iso"
DISK="/dev/sda"

lsblk "${DISK}"

read -rp "Write ${IMAGE} to ${DISK}? This will erase it. [y/N] " answer
[[ "${answer}" == "y" || "${answer}" == "Y" ]] || exit 1

sudo dd \
    if="${IMAGE}" \
    of="${DISK}" \
    bs=4M \
    status=progress \
    conv=fsync

