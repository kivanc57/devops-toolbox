#!/bin/bash
set -euo pipefail

sudo mysql -e "
ALTER USER 'root'@'localhost' IDENTIFIED VIA unix_socket;
DROP USER IF EXISTS ''@'$(hostname)';
DROP USER IF EXISTS 'root'@'%';
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;
"

