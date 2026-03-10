#!/usr/bin/env bash
set -euo pipefail

# Ansible is push-based
# you ONLY need new version of python3 on host
# you do NOT need ansible on host

sudo apt-get update -y
sudo apt-get install -y software-properties-common python3

sudo add-apt-repository -y ppa:ansible/ansible
sudo apt-get update -y

sudo apt-get install -y ansible

ansible --version

