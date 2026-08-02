#!/bin/bash
set -euo pipefail

source .env

: "${SITE_PASSWORD:?SITE_PASSWORD not set}"
: "${LOCAL_PASSWORD:?LOCAL_PASSWORD not set}"
: "${GLOBALEMAIL:?GLOBALEMAIL not set}"

export SITE_PASSWORD
export LOCAL_PASSWORD
export GLOBALEMAIL

sudo dnf update -y
sudo dnf install tripwire -y

"./setup-postfix.sh"

"./setup-tripwire.sh"

