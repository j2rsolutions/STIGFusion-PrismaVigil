
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214253
# Severity: high

# Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file
HTTPD_ROOT=$(apachectl -V | egrep -i 'httpd_root' | cut -d'"' -f2)
SERVER_CONFIG_FILE=$(apachectl -V | egrep -i 'server_config_file' | cut -d'"' -f2)

# Verify the "unique_id_module" is loaded
UNIQUE_ID_MODULE=$(httpd -M | grep unique_id)

if [[ -z "$UNIQUE_ID_MODULE" ]]; then
    echo "unique_id_module is not loaded"
    exit 1
else
    echo "unique_id_module is loaded"
    exit 0
fi

