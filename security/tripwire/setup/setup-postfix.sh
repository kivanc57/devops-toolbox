#!/bin/bash
set -euo pipefail

INTER_INTERFACES="localhost"
MAILNAME="localhost.localdomain"

sudo postconf -e "myhostname=${MAILNAME}"
sudo postconf -e "inet_interfaces"="${INTER_INTERFACES}"

sudo systemctl restart postfix

