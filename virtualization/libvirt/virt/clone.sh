#!/bin/bash
set -euo pipefail

read -rp "enter source image name: " SOURCE_VM
read -rp "enter clone image name: " CLONE_VM

CLONE_HOSTNAME="ubuntu-lts"
CLONE_DISK="/var/lib/libvirt/images/${CLONE_VM}.qcow2" 

# clone vm
sudo virt-clone --connect qemu:///system \
    --original "${SOURCE_VM}" \
    --name "${CLONE_VM}" \
    --file "${CLONE_DISK}" \
    --check disk_size=off

# remove id, ssh, tmp, log files
sudo virt-sysprep -d "${CLONE_VM}" \
  --operations machine-id,ssh-hostkeys,tmp-files,logfiles \
  --hostname "${CLONE_HOSTNAME}"

# regenerate ssh key
sudo virt-customize -d "${CLONE_VM}" \
  --run-command 'ssh-keygen -A' \
  --run-command 'systemctl enable ssh'

echo "clone created: ${CLONE_VM}"
echo "clone disk: ${CLONE_DISK}"

