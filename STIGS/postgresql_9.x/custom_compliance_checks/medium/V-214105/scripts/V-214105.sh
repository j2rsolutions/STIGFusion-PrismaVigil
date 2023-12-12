
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214105
# Severity: medium

# Check if pgaudit is enabled
pgaudit_check=$(sudo -u postgres psql -c "SHOW shared_preload_libraries" | grep pgaudit)

if [[ -z "$pgaudit_check" ]]; then
  echo "pgaudit is not enabled"
  exit 1
fi

# Check if role logging is enabled
role_check=$(sudo -u postgres psql -c "SHOW pgaudit.log" | grep role)

if [[ -z "$role_check" ]]; then
  echo "Role logging is not enabled"
  exit 1
fi

exit 0

