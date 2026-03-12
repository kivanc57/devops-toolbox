#!/bin/bash
set -euo pipefail

source .env
: "${LOCAL_PASSWORD:?LOCAL_PASSWORD is not set}"
export LOCAL_PASSWORD

TW_DIR="/var/lib/tripwire"
REPORT_DIR="${TW_DIR}/report"
REPORT_READABLE="${HOME}/tw-checks/report-$(date +%Y-%m-%d).txt"

# create report dir and output dir if they do NOT exist
sudo install -d -m 0700 "${REPORT_DIR}"
sudo chown -R root:root "${TW_DIR}"
mkdir -p "${HOME}/tw-checks"

# perform an integrity check & send email
sudo tripwire -m c \
    --local-passphrase "$LOCAL_PASSWORD" \
    --email-report \
    --email-report-level 1

# assign latest report to a var
REPORT_LATEST="$(ls -t ${REPORT_DIR}/*.twr | head -n1)"

# decode latest report
sudo twprint -m r \
    --local-passphrase "$LOCAL_PASSWORD" \
    -r "${REPORT_LATEST}" \
    | tee "${REPORT_READABLE}"

# update database
sudo tripwire -m u --local-passphrase "$LOCAL_PASSWORD" \
    -r "${REPORT_LATEST}"

