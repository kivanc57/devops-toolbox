#!/bin/bash
set -euo pipefail

source "./env.sh"

sudo lxc-destroy -n "${VM_NAME}" -f

sudo lxc-ls -f

