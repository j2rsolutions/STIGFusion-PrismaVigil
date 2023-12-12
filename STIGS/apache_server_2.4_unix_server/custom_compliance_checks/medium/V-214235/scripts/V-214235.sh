
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214235
# Severity: medium

# Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file
HTTPD_ROOT=$(apachectl -V | egrep -i 'httpd_root' | cut -d'"' -f2)
SERVER_CONFIG_FILE=$(apachectl -V | egrep -i 'server_config_file' | cut -d'"' -f2)

# Determine the location of the log files
LOG_DIR="${HTTPD_ROOT}/logs"

# Check the permissions of the log files
for LOG_FILE in $(ls ${LOG_DIR}/*log*); do
    PERMISSIONS=$(stat -c %a ${LOG_FILE})
    OWNER=$(stat -c %U ${LOG_FILE})
    GROUP=$(stat -c %G ${LOG_FILE})

    # Check if the permissions are set to 640 or more restrictive
    if [ ${PERMISSIONS} -gt 640 ]; then
        echo "Permissions for ${LOG_FILE} are not set to 640 or more restrictive"
        exit 1
    fi

    # Check if the owner and group are either root or apache
    if [ ${OWNER} != "root" ] && [ ${OWNER} != "apache" ]; then
        echo "Owner of ${LOG_FILE} is not root or apache"
        exit 1
    fi

    if [ ${GROUP} != "root" ] && [ ${GROUP} != "apache" ]; then
        echo "Group of ${LOG_FILE} is not root or apache"
        exit 1
    fi
done

# If the script has not exited by now, the check has passed
exit 0

