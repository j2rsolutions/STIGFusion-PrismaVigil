
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214257
# Severity: medium

HTTPD_ROOT=$(apachectl -V | egrep -i 'httpd_root' | cut -d'"' -f2)
SERVER_CONFIG_FILE=$(apachectl -V | egrep -i 'server_config_file' | cut -d'"' -f2)

if [ -z "$HTTPD_ROOT" ] || [ -z "$SERVER_CONFIG_FILE" ]; then
    echo "Unable to determine HTTPD_ROOT or SERVER_CONFIG_FILE"
    exit 1
fi

HTTPD_CONF="$HTTPD_ROOT/$SERVER_CONFIG_FILE"

if [ ! -f "$HTTPD_CONF" ]; then
    echo "httpd.conf file not found"
    exit 1
fi

TRACE_ENABLE=$(grep -i "TraceEnable" "$HTTPD_CONF")
LOG_LEVEL=$(grep -i "LogLevel" "$HTTPD_CONF")

if [ -z "$TRACE_ENABLE" ] || [ "$TRACE_ENABLE" != "Off" ]; then
    echo "TraceEnable directive is not set to Off or does not exist"
    exit 1
fi

if [ -z "$LOG_LEVEL" ]; then
    echo "LogLevel directive is not being used"
    exit 1
fi

exit 0

