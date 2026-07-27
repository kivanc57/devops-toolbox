#!/bin/bash
set -euo pipefail

source ./env.sh

# client-side
qm set "${VM_ID}" --agent enabled=1

qm reboot "${VM_ID}"
sleep 5

if qm guest cmd "${VM_ID}" ping; then
    echo "Guest agent works"
fi

