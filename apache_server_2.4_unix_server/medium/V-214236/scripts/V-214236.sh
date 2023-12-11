
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214236
# Severity: medium

# Check if the Apache server is installed
if [ ! -x "$(command -v apache2)" ]; then
  echo "Apache server is not installed."
  exit 1
fi

# Get the Apache server installation path
INSTALL_PATH=$(dirname $(dirname $(which apache2)))

# Check the ownership of the log files
LOG_FILES_OWNER=$(ls -ld $INSTALL_PATH/logs | awk '{print $3}')

# Replace 'admin' with the actual administrative service account
if [ "$LOG_FILES_OWNER" != "admin" ]; then
  echo "The Apache server log files are not owned by the administrative service account."
  exit 1
else
  echo "The Apache server log files are owned by the administrative service account."
  exit 0
fi

