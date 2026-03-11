#!/bin/bash
set -euo pipefail

# to avoid conflicts with SELinux
sudo systemctl disable apparmor

sudo apt-get update
sudo apt-get install -y \
  selinux-basics \
  selinux-utils \
  policycoreutils \
  setools

sudo selinux-activate
sudo reboot

