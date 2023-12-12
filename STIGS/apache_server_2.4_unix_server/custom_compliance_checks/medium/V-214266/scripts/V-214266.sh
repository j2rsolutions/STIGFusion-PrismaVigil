
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214266
# Severity: medium

# This script checks if HTTP and HTTPS are used in accordance with well known ports (80 and 443)

http_port=$(netstat -tuln | grep ':80 ')
https_port=$(netstat -tuln | grep ':443 ')

if [[ -z "$http_port" || -z "$https_port" ]]; then
  echo "V-214266: HTTP or HTTPS not used in accordance with well known ports (80 and 443)"
  exit 1
else
  echo "HTTP and HTTPS are used in accordance with well known ports (80 and 443)"
  exit 0
fi

