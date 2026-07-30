#!/bin/bash
set -euo pipefail

read -rp "enter vm name: " VM_NAME
read -rp "enter vm username: " VM_USERNAME

SSH_KEY_PATH="${HOME}/.ssh/id_ed25519.pub"

sudo virt-customize -d "${VM_NAME}" \
    --ssh-inject "${VM_USERNAME}:file:${SSH_KEY_PATH}"

