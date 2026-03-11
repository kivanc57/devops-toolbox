0. *0-trust policy*

1. setup `firewalld/ufw`

2. allow `http` & `https`

3. allow `ssh` only with specific ip & port
edit => `/etc/ssh/ssh_config`

4. `000-default.conf` -> set domain name & get certificate (Let's Encrypt)
`certbot --apache`

5. `SELinux` setup & group permissions & *the principle of least privilege*

6. isolate /w VMs & containers & microservices

7. check users with id: 0

8. `ss -tulpen`

9. `awk -F: '($3==0 && $1!="root") {print}' /etc/passwd`

10. `ss -tulpen`

10. ` systemctl list-unit-files --type=service --state=enabled`

97. `vpn` uses -> `tls/ssl` | `IPsec` | `WireGuard`

98. `https` uses -> `tls` relies -> `ca` cert

99. scam.io

