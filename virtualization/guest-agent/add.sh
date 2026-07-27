#!/bin/bash
set -euo pipefail

source ./env.sh

# server-side
sudo dnf install -y qemu-guest-agent

rpm -q qemu-guest-agent

systemctl is-active --quiet qemu-guest-agent
echo "QEMU guest agent is running"

ls -l /dev/virtio-ports/org.qemu.guest_agent.0

