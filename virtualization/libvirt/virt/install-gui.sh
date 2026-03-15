#!/bin/bash
set -euo pipefail

VM_NAME="ubuntu-24.04.3-tls-server"
OS_INFO="ubuntu24.04"
DISK_GB="25"
DISK_TYPE="qcow2"
MEMORY_MB="4096"
DISK_PATH="/var/lib/libvirt/images/${VM_NAME}.${DISK_TYPE}"
ISO_LOCATION="$HOME/Downloads/ubuntu-24.04.3-live-server-amd64.iso"
VM_NET="default"
CPUS="4"

virt-install \
	--name "${VM_NAME}" \
	--osinfo "${OS_INFO}" \
	--connect qemu:///system \
	--disk size="${DISK_GB}",format="${DISK_TYPE}",path="${DISK_PATH}",bus=virtio \
	--memory "${MEMORY_MB}" \
	--hvm \
	--cdrom "${ISO_LOCATION}" \
	--network network=${VM_NET},model=virtio \
	--vcpus "${CPUS}" \
	--virt-type kvm \
    --boot uefi \

