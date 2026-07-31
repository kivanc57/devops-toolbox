#!/bin/bash
set -euo pipefail

source ".env"
source "/etc/os-release"

: "${DB_NAME:?DB_NAME not set}"
: "${USERNAME:?USERNAME not set}"
: "${PASSWORD:?PASSWORD not set}"

export DB_NAME USERNAME PASSWORD

if [ "$ID" = "ubuntu" ]; then
    "./deps/ubuntu.sh"
    APACHE_CONFIG="/etc/apache2/sites-available/000-default.conf"
    SERVICE="apache2"
   
elif [ "$ID" = "fedora" ]; then
    "./deps/fedora.sh"
    APACHE_CONFIG="/etc/httpd/conf/httpd.conf"
    SERVICE="httpd"
fi

DOCUMENT_ROOT="$(
    awk '$1 == "DocumentRoot" {
        gsub(/"/, "", $2)
        print $2
        exit
    }' "$APACHE_CONFIG"
)"

printf 'Apache config: %s\n' "$APACHE_CONFIG"
printf 'Document root: %s\n' "$DOCUMENT_ROOT"

"./harden-server.sh"
"./build-db.sh"
"./build-nextcloud.sh" "$DOCUMENT_ROOT"

sudo chown -R apache:apache "${DOCUMENT_ROOT}"

sudo semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/html/config(/.*)?'
sudo semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/html/data(/.*)?'
sudo semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/html/apps(/.*)?'

sudo restorecon -RFv /var/www/html
sudo systemctl restart "$SERVICE"

