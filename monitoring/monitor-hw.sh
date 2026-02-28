#!/bin/bash
set -euo pipefail

# steps to manually load module for non-functional hw
# find module name for device on internet
# find /lib/modules/$(uname -r) -type f -name {module}*
# {module}.ko
# modprobe {module}

echo "=== all hw components ==="
sudo lshw   # or -class {specific_comp}
# for better visualization:
# lshw -html > lshw-output.html
echo

echo "=== kernel modules ==="
ls "/lib/modules"
echo "used: $(uname -r)"
echo

echo "=== active (loaded) modules ==="
lsmods

