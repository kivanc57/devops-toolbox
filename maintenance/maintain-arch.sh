#!/usr/bin/env bash
set -euo pipefail

log() { printf '\n[%s] %s\n' "$(date -Is)" "$*"; }

log "Syncing package databases and upgrading system..."
sudo pacman -Syu --noconfirm

log "Updating yay repository"
yay -Syu --noconfirm

log "Checking for failed systemd services (if any)..."
if command -v systemctl >/dev/null 2>&1; then
    systemctl --failed || true
fi

log "Removing orphaned packages..."
orphans="$(pacman -Qtdq || true)"
if [[ -n "${orphans}" ]]; then
    echo "${orphans}"
    sudo pacman -Rns --noconfirm "${orphans}"
else
    log "No orphaned packages found."
fi

if command -v paccache >/dev/null 2>&1; then
    log "Cleaning pacman cache (keeping last 3 versions)..."
    sudo paccache -r
else
    log "paccache not found (install pacman-contrib) - doing basic cache clean instead..."
    sudo pacman -Sc --noconfirm
fi

# Set periodic paccache cleanup
sudo systemctl enable --now paccache.timer

log "System maintenance complete."

