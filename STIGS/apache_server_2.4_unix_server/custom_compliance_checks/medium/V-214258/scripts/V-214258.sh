
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214258
# Severity: medium

# Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file
HTTPD_ROOT=$(apachectl -V | egrep -i 'httpd_root' | cut -d'"' -f2)
SERVER_CONFIG_FILE=$(apachectl -V | egrep -i 'server_config_file' | cut -d'"' -f2)

# Verify the "reqtimeout_module" is loaded
MODULE_LOADED=$(httpd -M | grep reqtimeout_module)

if [[ -z "$MODULE_LOADED" ]]; then
  echo "reqtimeout_module is not loaded"
  exit 1
fi

# Verify the "RequestReadTimeout" directive is configured
REQUEST_READ_TIMEOUT=$(grep -i "RequestReadTimeout" $HTTPD_ROOT/$SERVER_CONFIG_FILE)

if [[ -z "$REQUEST_READ_TIMEOUT" ]]; then
  echo "RequestReadTimeout directive is not configured"
  exit 1
fi

exit 0

