
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214250
# Severity: medium

HTTPD_ROOT=$(apachectl -V | egrep -i 'httpd_root' | cut -d'"' -f2)
SERVER_CONFIG_FILE=$(apachectl -V | egrep -i 'server_config_file' | cut -d'"' -f2)
HTTPD_CONF="${HTTPD_ROOT}/${SERVER_CONFIG_FILE}"

SESSION_MAX_AGE=$(cat ${HTTPD_CONF} | grep -i "SessionMaxAge" | awk '{print $2}')

if [[ -z "${SESSION_MAX_AGE}" ]] || [[ "${SESSION_MAX_AGE}" -gt 600 ]]; then
    echo 'SessionMaxAge is not set or is set to more than 600'
    exit 1
fi

exit 0

