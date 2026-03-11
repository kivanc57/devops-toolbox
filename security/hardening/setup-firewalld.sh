#!/bin/bash
set -euo pipefail

source .env

: "${IP:?IP not set}"
: "${PORT:?PORT not set}"

export IP
export PORT

RULE_FAMILY="ipv4"
PROTOCOL="tcp"

sudo apt-get update
sudo apt-get install firewalld -y

sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https

sudo firewall-cmd --permanent --remove-service=ssh

sudo firewall-cmd --permanent --add-rich-rule="rule family=${RULE_FAMILY} source address=${IP} port port=${PORT} protocol=${PROTOCOL} accept"

sudo firewall-cmd --reload
sudo firewall-cmd --list-all 

