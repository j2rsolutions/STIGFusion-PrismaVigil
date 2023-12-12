
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214232
# Severity: medium

# Check if log_config_module is enabled
if ! httpd -M | grep -iq "log_config_module"; then
    echo "log_config_module is not enabled"
    exit 1
fi

# Determine the location of the HTTPD_ROOT directory and the httpd.conf file
HTTPD_ROOT=$(apachectl -V | egrep -i 'httpd_root' | cut -d'"' -f2)
SERVER_CONFIG_FILE=$(apachectl -V | egrep -i 'server_config_file' | cut -d'"' -f2)

# Check if LogFormat directive is present in the httpd.conf file
if ! cat ${HTTPD_ROOT}/${SERVER_CONFIG_FILE} | grep -iq "LogFormat"; then
    echo "LogFormat directive is missing in httpd.conf"
    exit 1
fi

# If all checks pass, exit with 0
exit 0

