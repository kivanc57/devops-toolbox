#!/bin/bash
set -euo pipefail

# check if inet assigned
echo "=== all setwork interfaces and ips ==="
ip -br a 
echo

# check if net interface assigned
echo "=== ip routes ==="
ip route
echo

# check if net interfaces assigned to adapters
echo "=== pci hardware devices ==="
lspci -nnk | grep -A3 -Ei 'network|ethernet'
echo

# check logs of net interfaces
echo "=== kernel log messages of net interfaces"
ETH_ADAPT="$(ip -o link show | grep -o 'enp[^:]*')"
WIFI_ADAPT="$(ip -o link show | grep -o 'wlp[^:]*')"

echo "=== ethernet adapter ==="
sudo dmesg | grep -E "${ETH_ADAPT}"
echo

echo "=== wifi adapter ==="
sudo dmesg | grep -E "${WIFI_ADAPT}"
echo

echo "=== listening services (ports) ==="
sudo ss -tulnp
echo

echo "=== active TCP connections ==="
sudo ss -antp
echo

