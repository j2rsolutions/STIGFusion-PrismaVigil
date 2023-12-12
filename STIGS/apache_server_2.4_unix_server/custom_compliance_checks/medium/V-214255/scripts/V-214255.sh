
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214255
# Severity: medium

# Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file
HTTPD_ROOT=$(apachectl -V | egrep -i 'httpd_root' | cut -d'"' -f2)
SERVER_CONFIG_FILE=$(apachectl -V | egrep -i 'server_config_file' | cut -d'"' -f2)

# Verify that the "Timeout" directive is specified to have a value of "10" seconds or less.
TIMEOUT_VALUE=$(cat ${HTTPD_ROOT}/${SERVER_CONFIG_FILE} | grep -i "Timeout" | awk '{print $2}')

if [[ -z "${TIMEOUT_VALUE}" || "${TIMEOUT_VALUE}" -gt 10 ]]; then
    echo 'Timeout directive is not configured or is set for more than "10" seconds'
    exit 1
fi

exit 0

