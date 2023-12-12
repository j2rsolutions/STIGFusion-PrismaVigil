
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214251
# Severity: medium

# Check if the headers_module (shared) is loaded in the web server
MODULE_CHECK=$(httpd -M | grep "headers_module (shared)")

if [[ -z "$MODULE_CHECK" ]]; then
  echo "headers_module (shared) is not loaded"
  exit 1
fi

# Check the SessionCookieName settings
COOKIE_SETTINGS=$(grep SessionCookieName /path/to/mod_session.conf)

if [[ "$COOKIE_SETTINGS" == *"HttpOnly"* ]] && [[ "$COOKIE_SETTINGS" == *"Secure"* ]] && [[ "$COOKIE_SETTINGS" != *"Domain"* ]]; then
  echo "Cookie settings are correct"
  exit 0
else
  echo "Cookie settings are incorrect"
  exit 1
fi

