
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214228
# Severity: medium

# Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file
HTTPD_ROOT=$(apachectl -V | egrep -i 'httpd_root' | cut -d'"' -f2)
SERVER_CONFIG_FILE=$(apachectl -V | egrep -i 'server_config_file' | cut -d'"' -f2)

# Full path to the httpd.conf file
HTTPD_CONF="${HTTPD_ROOT}/${SERVER_CONFIG_FILE}"

# Check if KeepAlive is set to off or does not exist
if ! grep -iq "KeepAlive On" "$HTTPD_CONF"; then
    echo "KeepAlive is set to off or does not exist"
    exit 1
fi

# Check if MaxKeepAliveRequests is set to a value less than 100 or does not exist
if ! awk -F' ' '/MaxKeepAliveRequests/ {if ($2 < 100) exit 1}' "$HTTPD_CONF"; then
    echo "MaxKeepAliveRequests is set to a value less than 100 or does not exist"
    exit 1
fi

# If we've made it here, both checks have passed
exit 0

