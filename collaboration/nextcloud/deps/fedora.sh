#!/bin/bash
set -euo pipefail

sudo dnf upgrade -y

sudo dnf install -y \
    httpd \
    mariadb-server \
    libapache2-mod-php \
    php-gd \
    php-mysql \
    php-curl \
    php-mbstring \
    php-intl \
    php-gmp \
    php-xml \
    php-imagick \
    php-pecl-zip

sudo systemctl enable --now httpd
sudo systemctl enable --now mariadb

sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload

