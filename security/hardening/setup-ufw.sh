#!/bin/bash
set -euo pipefail

source .env

: "${IP:?IP not set}"
: "${PORT:?PORT not set}"

export IP
export PORT

sudo apt-get update
sudo apt-get install ufw -y

sudo ufw disable
sudo ufw allow http
sudo ufw allow https
sudo allow from "${IP}" any port "${PORT}"

sudo ufw enable
sudo ufw status

