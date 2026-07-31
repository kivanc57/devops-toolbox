#!/bin/bash
set -euo pipefail

sudo apt-get update

sudo apt install -y \
    apache2 \
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
    php-zip

sudo systemctl enable --now apache2
sudo systemctl enable --now mariadb

