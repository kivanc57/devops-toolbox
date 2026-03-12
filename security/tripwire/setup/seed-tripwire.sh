#!/bin/bash
set -euo pipefail

SEED_FILE=$(mktemp)
trap 'rm -f "$SEED_FILE"' EXIT

cat > "$SEED_FILE" <<EOF
tripwire tripwire/site-passphrase password "${SITE_PASSWORD}"
tripwire tripwire/site-passphrase-again password "${SITE_PASSWORD}"
tripwire tripwire/local-passphrase password "${LOCAL_PASSWORD}"
tripwire tripwire/local-passphrase-again password "${LOCAL_PASSWORD}"
tripwire tripwire/install-note boolean true
EOF

sudo debconf-set-selections "${SEED_FILE}"
rm -f "${SEED_FILE}"

