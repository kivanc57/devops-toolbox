#!/bin/bash
set -euo pipefail

read -rp "enter vm username: " VM_USERNAME
read -rp "enter vm ip: " VM_IP

SSH_KEY_PATH="${HOME}/.ssh/id_ed25519.pub"

ssh-copy-id -i "${SSH_KEY_PATH}" "${VM_USERNAME}@${VM_IP}"

