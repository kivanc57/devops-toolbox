#!/bin/bash
set -euo pipefail

echo "SECURITY RESULTS OF ${HOSTNAME}: $(date +%Y-%m-%d)"

# scan malicious users
UID0_USERS="$(
  awk -F: '($3==0 && $1!="root"){
    printf "user=%s uid=%s gid=%s home=%s shell=%s\n",
    $1,$3,$4,$6,$7
  }' /etc/passwd || true
)"
echo " "
if [ -n "$UID0_USERS" ]; then
    echo "==== DANGEROUS USERS DETECTED ===="
    echo "$UID0_USERS"
    echo "================================="
    echo " "
    exit 1
else
    echo "no dangerous users found"
    echo " "
fi

# scan services
systemctl list-unit-files --type=service --state=enabled
echo " "

# scan open ports
ss -tulpen

