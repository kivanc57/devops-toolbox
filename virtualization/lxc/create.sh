#!/bin/bash
set -euo pipefail

source "./env.sh"

# enable lxc bridge usage one time:
# sudo sed -i 's/^USE_LXC_BRIDGE="false"/USE_LXC_BRIDGE="true"/' /etc/sysconfig/lxc
# sudo systemctl enable --now lxc-net.service


# for interactive execution:
# sudo lxc-create -n "${VM_NAME}" -t download

DIST="ubuntu"
RELEASE="noble"
ARCH="amd64"

sudo lxc-create \
  -n "${VM_NAME}" \
  -t download \
  -- \
  --dist "${DIST}" \
  --release  "${RELEASE}" \
  --arch "${ARCH}"

sudo lxc-start -n "${VM_NAME}"

sudo lxc-ls -f

sudo lxc-attach -n "${VM_NAME}"

