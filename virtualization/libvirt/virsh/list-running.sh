#!/bin/bash
set -euo pipefail

DOMS="$(virsh list --name --state-running)"

for dom in ${DOMS}; do
    echo "===== vm: ${dom} ====="
    virsh domifaddr "${dom}"
done

