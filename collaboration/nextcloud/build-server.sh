#!/bin/bash
set -euo pipefail

# use ip of host to connect on browser at client
# DocumentRoot -> /etc/apache2/sites-available/000-default.conf
# defualt server root -> /var/www/html
# http://192.168.122.90/mw-config/index.php

source .env

: "${DB_NAME:?DB_NAME not set}"
: "${USERNAME:?USERNAME not set}"
: "${PASSWORD:?PASSWORD not set}"

export DB_NAME
export USERNAME
export PASSWORD

sudo apt-get update

# install mariadb first to avoid conflicts with mysql
sudo apt-get install mariadb-server -y
sudo systemctl start mariadb
sudo systemctl enable mariadb

sudo apt-get install -y \
    lamp-server^ \
    libapache2-mod-php \
    php \
    php-mysql \
    php-apcu \
    php-imagick \
    php8.3-mbstring \
    php8.3-xml \
    php8.3-intl \
    php8.3-gd

# execute custom scripts
"./harden-server.sh"    #or mysql_secure_installation interactively

"/.build-db.sh"

"/.build-nextcloud.sh"

