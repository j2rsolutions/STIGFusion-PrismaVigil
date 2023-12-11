
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214243
# Severity: medium

# Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file
HTTPD_ROOT=$(apachectl -V | egrep -i 'httpd_root' | cut -d'"' -f2)
SERVER_CONFIG_FILE=$(apachectl -V | egrep -i 'server_config_file' | cut -d'"' -f2)

# Full path to httpd.conf
HTTPD_CONF="${HTTPD_ROOT}/${SERVER_CONFIG_FILE}"

# Check if "Action" or "AddHandler" exist and they configure .exe, .dll, .com, .bat, or .csh, or any other shell as a viewer for documents
if grep -iE "Action|AddHandler" "${HTTPD_CONF}" | grep -iE "\.exe|\.dll|\.com|\.bat|\.csh"; then
    echo "STIG Finding ID: V-214243. Action or AddHandler directives configure a shell as a viewer for documents."
    exit 1
else
    echo "STIG Finding ID: V-214243. No Action or AddHandler directives configure a shell as a viewer for documents."
    exit 0
fi

