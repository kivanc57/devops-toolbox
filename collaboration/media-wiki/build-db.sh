#!/bin/bash
set -euo pipefail

sudo mariadb <<EOF
CREATE DATABASE ${DB_NAME};
CREATE USER '${USERNAME}'@'localhost' IDENTIFIED BY '${PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${USERNAME}'@'localhost';
FLUSH PRIVILEGES;
EOF

