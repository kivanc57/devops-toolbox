#!/bin/bash
set -euo pipefail

sudo apt-get update

sudo apt-get install -y \
    apache2 \
    mariadb-server \
    libapache2-mod-php \
    php \
    php-intl \
    php-mbstring \
    php-apcu \
    php-curl \
    php-mysql \
    php-xml

sudo systemctl enable --now apache2
sudo systemctl enable --now mariadb

