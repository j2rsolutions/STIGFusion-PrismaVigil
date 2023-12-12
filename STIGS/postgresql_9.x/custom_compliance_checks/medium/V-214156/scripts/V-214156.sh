
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214156
# Severity: medium

# Check if pgaudit is enabled
pgaudit_check=$(sudo -u postgres psql -c "SHOW shared_preload_libraries" | grep pgaudit)

if [[ -z "$pgaudit_check" ]]; then
  echo "pgaudit is not enabled"
  exit 1
fi

# Check if connections are being logged
log_connections_check=$(sudo -u postgres psql -c "SHOW log_connections" | grep on)

if [[ -z "$log_connections_check" ]]; then
  echo "Connections are not being logged"
  exit 1
fi

# Check if disconnections are being logged
log_disconnections_check=$(sudo -u postgres psql -c "SHOW log_disconnections" | grep on)

if [[ -z "$log_disconnections_check" ]]; then
  echo "Disconnections are not being logged"
  exit 1
fi

exit 0

