
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214259
# Severity: medium

HTTPD_ROOT=$(apachectl -V | egrep -i 'httpd_root' | cut -d'"' -f2)
SERVER_CONFIG_FILE=$(apachectl -V | egrep -i 'server_config_file' | cut -d'"' -f2)

if [ -z "$HTTPD_ROOT" ] || [ -z "$SERVER_CONFIG_FILE" ]; then
    echo "Unable to determine HTTPD_ROOT or SERVER_CONFIG_FILE"
    exit 1
fi

HTTPD_CONF="$HTTPD_ROOT/$SERVER_CONFIG_FILE"

if [ ! -f "$HTTPD_CONF" ]; then
    echo "httpd.conf file not found"
    exit 1
fi

REQUIRE_ALL=$(cat "$HTTPD_CONF" | grep -i "RequireAll")

if [ -z "$REQUIRE_ALL" ]; then
    echo "RequireAll is not configured"
    exit 1
fi

# Assuming that the IP ranges should be within the private IP address space
if echo "$REQUIRE_ALL" | grep -Pv 'Require ip (10\.|172\.(1[6-9]|2[0-9]|3[01])\.|192\.168\.)'; then
    echo "IP ranges configured to allow are not restrictive enough"
    exit 1
fi

exit 0

