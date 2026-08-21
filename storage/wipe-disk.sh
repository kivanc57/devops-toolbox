#!/bin/bash
set -euo pipefail

DISK="/dev/sda"

read -rp "Wipe ${DISK}? This will erase it. [y/N] " answer
[[ "${answer}" == "y" || "${answer}" == "Y" ]] || exit 1

sudo wipefs --all "${DISK}"

