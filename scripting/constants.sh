#!/bin/bash
set -euo pipefail

# script consonants
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"

# source necessay files
source "${SCRIPT_DIR}/.env"
source "${SCRIPT_DIR}/utils.sh"

# app-specific constants
DEPENDENCIES=(git docker nvm)

# check environment variables
log "Checking environtment variables..."
require_env REGISTRY_URL
require_env REGISTRY_USERNAME
require_env REGISTRY_PASSWORD

# check & install necessary dependencies
log "Checking dependencies..."
for dep in "${DEPENDENCIES[@]}"; do
	install_if_missing "$dep"
done

