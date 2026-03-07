#!/bin/bash
set -euo pipefail

# threshold function for comparsion
comp_thresh(){
    local major="$1"
    local minor="$2"
    local unit_name="$3"
    
    local threshold
    threshold=$(echo "$major * 0.80" | bc -l)

    if (( $(echo "${minor} >= ${threshold}" | bc -l) )); then
        echo "=== ${unit_name} overloaded!! ==="
        exit 1
    fi
}


echo "===== CPU RELATED STATISTICS ====="
echo

echo "=== uptime ==="
uptime
echo

CPU_CORES="$(nproc)"
LOAD_AVG="$(awk '{print $3}' /proc/loadavg)"
echo "=== load avg in 15min:  ${LOAD_AVG}"

comp_thresh "${CPU_CORES}" "${LOAD_AVG}" "CPUs"
echo
echo


echo "===== MEMORY RELATED STATISTIC ====="
# vmstat for real-time & interactive swap stats

MEM_TOTAL="$(free -b | awk '/^Mem:/ {print $2}')"
MEM_USED="$(free -b | awk '/^Mem:/  {print $3}')"
comp_thresh "${MEM_TOTAL}" "${MEM_USED}" "memory"
echo

echo "=== disk availability ==="
df -Th
echo

echo "=== system folders' storage ==="
du -xh --max-depth=1 / 2>/dev/null | sort -hr
echo

echo "=== short report of res since boot ==="
vmstat -wty

