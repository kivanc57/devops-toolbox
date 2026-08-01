#!/bin/bash
set -euo pipefail

echo "=== enabled services ==="
systemctl list-unit-files --type=service --state=enabled --no-pager
echo

echo
echo "=== installed apps ==="
dnf list --installed

