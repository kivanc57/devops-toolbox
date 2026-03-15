#!/bin/bash
set -euo pipefail

# this script intends to remove pass authentication
# you MUST still pair machines before using
#
# use this command to ssh into server:
# ssh -v sv_username@sv_ip

read -rp "enter vm name: " VM_NAME
read -rp "enter vm username: " VM_USERNAME

SSH_KEY="id_ed25519.pub"

sudo virt-customize -d "${VM_NAME}" \
    --ssh-inject "${VM_USERNAME}:file:${HOME}/.ssh/${SSH_KEY}"

