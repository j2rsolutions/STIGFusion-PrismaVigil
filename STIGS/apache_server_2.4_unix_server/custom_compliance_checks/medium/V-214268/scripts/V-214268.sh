
#!/bin/bash

# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214268
# Severity: medium

HTTPD_ROOT=$(apachectl -V | grep -i 'httpd_root' | cut -d'"' -f2)
SERVER_CONFIG_FILE=$(apachectl -V | grep -i 'server_config_file' | cut -d'"' -f2)
HTTPD_CONF="${HTTPD_ROOT}/${SERVER_CONFIG_FILE}"

SESSION_STATUS=$(cat ${HTTPD_CONF} | grep -i "Session" | awk '{print $2}')
SESSION_COOKIE_NAME=$(cat ${HTTPD_CONF} | grep -i "SessionCookieName" | awk '{print $2}')

if [[ -z ${SESSION_STATUS} || -z ${SESSION_COOKIE_NAME} ]]; then
    echo "Session or SessionCookieName directive is not present"
    exit 1
fi

if [[ ${SESSION_STATUS} != "on" || ${SESSION_COOKIE_NAME} != *"httpOnly"* || ${SESSION_COOKIE_NAME} != *"Secure"* ]]; then
    echo "Session is not set to on or SessionCookieName does not contain httpOnly and Secure"
    exit 1
fi

exit 0

