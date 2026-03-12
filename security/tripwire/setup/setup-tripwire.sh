#!/bin/bash
set -euo pipefail

# Recovery commands for twcfg.txt & twpol.txt values
# In order to retrieve default values and edit them
#
# twadmin --print-cfgfile > "${TWCFG_DIR}"
# twadmin --print-polfile > "${TWPOL_DIR}"

TW_DIR="/etc/tripwire"
TWCFG_DIR="${TW_DIR}/twcfg.txt"
TWPOL_DIR="${TW_DIR}/twpol.txt"

SITE_KEY="${TW_DIR}/site.key"
LOCAL_KEY="${TW_DIR}/$(hostname -s)-local.key"

# add user mail
echo "GLOBALEMAIL =${GLOBALEMAIL}" | sudo tee -a "${TWCFG_DIR}" &>/dev/null

# remove old site key & local key
sudo rm -f "${SITE_KEY}" "${LOCAL_KEY}"

# generate site key & local key
sudo twadmin --generate-keys \
    --site-keyfile "${SITE_KEY}" \
    --local-keyfile "${LOCAL_KEY}" \
    --site-passphrase "${SITE_PASSWORD}" \
    --local-passphrase "${LOCAL_PASSWORD}" \

# create tw.cfg (encrypted)
sudo twadmin --create-cfgfile \
  --site-keyfile "${SITE_KEY}" \
  --site-passphrase "${SITE_PASSWORD}" \
  "${TWCFG_DIR}"

# create tw.pol (encrypted)
sudo twadmin --create-polfile \
  --site-keyfile "${SITE_KEY}"\
  --site-passphrase "${SITE_PASSWORD}" \
  "${TWPOL_DIR}"

# init database
sudo tripwire --init \
  --local-passphrase "$LOCAL_PASSWORD"

