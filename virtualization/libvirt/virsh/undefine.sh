#!/bin/bash
set -euo pipefail

read -rp "enter vm name to remove: " VM_NAME

DISK="/var/lib/libvirt/images/${VM_NAME}.qcow2"

virsh destroy "${VM_NAME}" >/dev/null 2>&1 || true
virsh undefine "${VM_NAME}" --nvram || true
sudo rm -f "${DISK}"

if virsh dominfo "$VM_NAME" >/dev/null 2>&1; then
  echo "vm: $VM_NAME still exists"
else
  echo "vm: $VM_NAME removed"
fi

DISK="/var/lib/libvirt/images/${VM_NAME}.qcow2"
if [[ -e "$DISK" ]]; then
  echo "disk still exists: $DISK"
else
  echo "disk removed: $DISK"
fi

