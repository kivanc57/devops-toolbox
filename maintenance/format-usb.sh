#!/bin/bash
set -euo pipefail

echo "=== available devices ===="
lsblk

read -rp "enter usb name: " USB_NAME
DEV="/dev/$USB_NAME}"

sudo umount "${DEV}"* 2>/dev/null || true

sudo wipefs -a "${DEV}"

sudo parted -s "${DEV}" mklabel gpt
sudo parted -s -a optimal "${DEV}" mkpart primary ext4 1MiB 100%
sudo partprobe "${DEV}" || true

sudo mkfs.exfat "${DEV}1"

