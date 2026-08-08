#!/bin/bash
set -euo pipefail

USB_DEVICE_FILE="/dev/sda"
BACKUP_MBR="/tmp/usbMBR.bak"

# print disk & choose usb
lsblk

# print partitions & list files
sudo fdisk -l "${USB_DEVICE_FILE}"
ls -l "/mnt"

# backup USB
sudo dd if="${USB_DEVICE_FILE}" of="${BACKUP_MBR}"

# destroy USB
sudo dd if="/dev/urandom" of="${USB_DEVICE_FILE}"

# print partitions & fail
sudo fdisk -l "${USB_DEVICE_FILE}"

# try mount & fail 
sudo mount "${USB_DEVICE_FILE}1" /mnt || true

# restore USB using previous MBR
sudo dd if="${BACKUP_MBR}" of="${USB_DEVICE_FILE}" 

# mount & list
sudo mount "${USB_DEVICE_FILE}1" "/mnt"
ls -l "/mnt"

