
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214244
# Severity: medium

# Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file
HTTPD_ROOT=$(apachectl -V | egrep -i 'httpd_root' | cut -d'"' -f2)
SERVER_CONFIG_FILE=$(apachectl -V | egrep -i 'server_config_file' | cut -d'"' -f2)

# Locate "cgi-bin" files and directories enabled in the Apache configuration
SCRIPTS=$(cat ${HTTPD_ROOT}/${SERVER_CONFIG_FILE} | grep -i "Script")

# Check if any scripts are present that are not needed for application operation
if [ -n "$SCRIPTS" ]; then
    echo "Unnecessary scripts found in Apache configuration"
    exit 1
else
    echo "No unnecessary scripts found in Apache configuration"
    exit 0
fi

