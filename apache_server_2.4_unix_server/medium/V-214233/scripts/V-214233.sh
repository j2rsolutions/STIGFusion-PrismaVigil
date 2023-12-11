
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214233
# Severity: medium

# Check if Apache server is installed
if ! command -v apachectl &> /dev/null
then
    echo "Apache server is not installed. Exiting with code 0."
    exit 0
fi

# Get the HTTPD_ROOT and SERVER_CONFIG_FILE
HTTPD_ROOT=$(apachectl -V | grep -i 'httpd_root' | cut -d'"' -f2)
SERVER_CONFIG_FILE=$(apachectl -V | grep -i 'server_config_file' | cut -d'"' -f2)

# Get the full path to the httpd.conf file
HTTPD_CONF="${HTTPD_ROOT}/${SERVER_CONFIG_FILE}"

# Check if the httpd.conf file exists
if [ ! -f "$HTTPD_CONF" ]
then
    echo "httpd.conf file does not exist. Exiting with code 1."
    exit 1
fi

# Get the log file location
LOG_FILE=$(grep "CustomLog" $HTTPD_CONF | awk '{print $2}' | tr -d '"')

# Check if the log file exists
if [ ! -f "$LOG_FILE" ]
then
    echo "Log file does not exist. Exiting with code 1."
    exit 1
fi

# Check if the log entries reflect the IP address of the proxy server as the source
if grep -q "proxy" "$LOG_FILE"
then
    echo "Log entries reflect the IP address of the proxy server as the source. Exiting with code 1."
    exit 1
else
    echo "Log entries do not reflect the IP address of the proxy server as the source. Exiting with code 0."
    exit 0
fi

