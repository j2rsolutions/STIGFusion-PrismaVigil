
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214246
# Severity: medium

HTTPD_ROOT=$(apachectl -V | egrep -i 'httpd_root' | cut -d'"' -f2)
SERVER_CONFIG_FILE=$(apachectl -V | egrep -i 'server_config_file' | cut -d'"' -f2)
HTTPD_CONF="${HTTPD_ROOT}/${SERVER_CONFIG_FILE}"

if [ ! -f "$HTTPD_CONF" ]; then
    echo "httpd.conf file not found"
    exit 1
fi

LISTEN_DIRECTIVES=$(grep -i "Listen" "$HTTPD_CONF")

if [ -z "$LISTEN_DIRECTIVES" ]; then
    echo "Listen directive does not exist"
    exit 1
fi

for directive in $LISTEN_DIRECTIVES; do
    IP_ADDRESS=$(echo "$directive" | cut -d':' -f1)
    PORT_NUMBER=$(echo "$directive" | cut -d':' -f2)

    if [ -z "$IP_ADDRESS" ] || [ -z "$PORT_NUMBER" ]; then
        echo "Listen directive with only an IP address or only a port number specified"
        exit 1
    fi

    if [ "$IP_ADDRESS" == "0.0.0.0" ] || [ "$IP_ADDRESS" == "[::ffff:0.0.0.0]" ]; then
        echo "Listen directive with IP address all zeros"
        exit 1
    fi
done

exit 0

