#!/bin/bash
set -euo pipefail

install_if_missing(){
    for cmd in "$@"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            echo "[INFO] ${cmd} NOT installed. Installing..."
            local script="./install-${cmd}.sh"

            if [ -f "${script}" ]; then
                chmod +x "${script}"
                "${script}"
            else
                echo "[EROR] install script ${script} not found"
                continue
            fi
        else
            echo "[OK] $cmd already installed"
        fi
    done
}

install_if_missing "$@"

