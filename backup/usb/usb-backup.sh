#!/bin/bash
set -euo pipefail

destination="/run/media/kivanc57/USB"
sources=("$@")

if (( $# == 0 )); then
    echo "Usage: $0 SOURCE [SOURCE ...]" >&2
    exit 1
fi

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

rsync    "${options[@]}" "${sources[@]}" "$destination"
sync
udisksctl unmount -b /dev/sda1
udisksctl power-off -b /dev/sda

