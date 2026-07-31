#!/bin/bash
set -euo pipefail

sudo dnf upgrade -y

sudo dnf install -y \
    httpd \
    mariadb-server \
    php \
    php-mysqlnd \
    php-pecl-apcu \
    php-pecl-imagick \
    php-mbstring \
    php-xml \
    php-intl \
    php-gd

sudo systemctl enable --now httpd
sudo systemctl enable --now mariadb

sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload

