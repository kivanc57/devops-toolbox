#!/bin/bash
set -euo pipefail

mount_path="/run/media/kivanc57/USB"
device_path="/dev/sda"
sources=("$@")

options=(
    -ah
    --no-links
    --info=progress2
    --exclude='venv/'
    --exclude='.venv/'
    --exclude='node_modules/'
    --exclude='.git/'
    --exclude='*:*'
    --exclude=$'*\n*'
)

# mount USB
udiskctl mount -b "${mount_path}1"

# backup files -> USB & sync
rsync    "${options[@]}" "${sources[@]}" "${mount_path}"
sync

# unmount & power off before ejection
udisksctl unmount -b "${device_path}1"
udisksctl power-off -b "${device_path}"

