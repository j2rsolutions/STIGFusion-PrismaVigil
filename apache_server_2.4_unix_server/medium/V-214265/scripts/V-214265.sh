
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214265
# Severity: medium

# Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file
HTTPD_ROOT=$(apachectl -V | egrep -i 'httpd_root' | cut -d'"' -f2)
SERVER_CONFIG_FILE=$(apachectl -V | egrep -i 'server_config_file' | cut -d'"' -f2)

# Full path to httpd.conf
HTTPD_CONF="${HTTPD_ROOT}/${SERVER_CONFIG_FILE}"

# Check if "LogFormat" directive exists
if ! grep -iq "LogFormat" "$HTTPD_CONF"; then
  echo "LogFormat directive does not exist"
  exit 1
fi

# Check if "%t" flag is present in "LogFormat" directive
if ! grep -iq "LogFormat" "$HTTPD_CONF" | grep -iq "%t"; then
  echo "Time is not mapped to UTC or GMT time in LogFormat directive"
  exit 1
fi

# If the script has not exited by now, the check has passed
exit 0

