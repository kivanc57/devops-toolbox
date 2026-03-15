#!/bin/bash
set -euo pipefail

# use this in case virsh console does NOT work
# afte execution, reboot and virsh console [id-name] to vm

sudo sed -i 's|^GRUB_CMDLINE_LINUX=".*"|GRUB_CMDLINE_LINUX="console=ttyS0,115200n8"|' "/etc/default/grub"

sudo systemctl enable serial-getty@ttyS0.service

sudo update-grub

