#!/bin/bash
set -euo pipefail

DISK="/dev/nvme0n1"

if sudo dd if="${DISK}" of=/dev/null bs=4M status=progress; then
    echo "Disk read completed without errors."
else
    echo "Disk has read errors."
fi

