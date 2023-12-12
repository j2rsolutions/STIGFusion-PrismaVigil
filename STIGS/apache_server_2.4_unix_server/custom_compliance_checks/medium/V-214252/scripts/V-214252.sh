
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214252
# Severity: medium

# Check if session_crypto is enabled
if ! httpd -M | grep -q "session_crypto_module"; then
  echo "session_crypto_module is not enabled"
  exit 1
fi

# Determine the location of the HTTPD_ROOT directory and the httpd.conf file
HTTPD_ROOT=$(apachectl -V | grep -i 'HTTPD_ROOT' | cut -d'"' -f2)
SERVER_CONFIG_FILE=$(apachectl -V | grep -i 'SERVER_CONFIG_FILE' | cut -d'"' -f2)

# Full path to the httpd.conf file
HTTPD_CONF="${HTTPD_ROOT}/${SERVER_CONFIG_FILE}"

# Check if SessionCryptoCipher is used and set to aes256
if ! grep -q "SessionCryptoCipher aes256" "$HTTPD_CONF"; then
  echo "SessionCryptoCipher is not used or not set to aes256"
  exit 1
fi

# If we made it here, the check passed
exit 0

