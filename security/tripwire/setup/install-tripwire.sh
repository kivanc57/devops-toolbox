#!/bin/bash
set -euo pipefail

source .env

: "${SITE_PASSWORD:?SITE_PASSWORD not set}"
: "${LOCAL_PASSWORD:?LOCAL_PASSWORD not set}"
: "${GLOBALEMAIL:?GLOBALEMAIL not set}"

export SITE_PASSWORD
export LOCAL_PASSWORD
export GLOBALEMAIL

"./seed-tripwire.sh"

sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y postfix tripwire

"./setup-postfix.sh"

"./setup-tripwire.sh"

