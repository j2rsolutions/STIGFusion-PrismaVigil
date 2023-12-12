
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214123
# Severity: medium

# Check if pgaudit is in the current setting
pgaudit_check=$(sudo -u postgres psql -c "SHOW shared_preload_libraries" | grep pgaudit)

# Check if stderr or syslog are in the current setting
log_destination_check=$(sudo -u postgres psql -c "SHOW log_destination" | grep -E 'stderr|syslog')

# If pgaudit is not in the current setting, exit with 1
if [[ -z "$pgaudit_check" ]]; then
  echo 'pgaudit is not in the current setting'
  exit 1
fi

# If stderr or syslog are not in the current setting, exit with 1
if [[ -z "$log_destination_check" ]]; then
  echo 'stderr or syslog are not in the current setting'
  exit 1
fi

# If both checks pass, exit with 0
exit 0

