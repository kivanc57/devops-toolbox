#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

log() { printf '\n[%s] %s\n' "$(date -Is)" "$*"; }

log "Updating package lists..."
sudo apt-get update -yq

log "Upgrading installed packages..."
sudo apt-get upgrade -yq

log "Performing full upgrade (dist-upgrade)..."
sudo apt-get dist-upgrade -yq

log "Removing unused packages..."
sudo apt-get autoremove --purge -yq

log "Checking for broken dependencies..."
sudo apt-get check

if command -v purge-old-kernels >/dev/null 2>&1; then
    log "Purging old kernels..."
    sudo purge-old-kernels -qy
else
    log "purge-old-kernels not found; skipping explicit kernel purge."
fi

if command -v deborphan >/dev/null 2>&1; then
    orphans="$(deborphan || true)"
    if [[ -n "${orphans}" ]]; then
        log "Removing orphaned packages:"
        printf '%s\n' "${orphans}"
    # xargs -r = do nothing if empty (GNU). If on BSD, you may need a different guard.
        printf '%s\n' "${orphans}" | xargs -r sudo apt-get -yq remove --purge
  else
    log "No orphaned packages found."
  fi
else
    log "deborphan not installed; skipping orphan removal."
fi

log "Cleaning apt cache..."
sudo apt-get autoclean -yq

log "System maintenance complete."

