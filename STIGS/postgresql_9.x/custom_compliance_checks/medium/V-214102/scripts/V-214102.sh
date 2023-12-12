
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214102
# Severity: medium

# Check if pgaudit is enabled
pgaudit_check=$(sudo -u postgres psql -c "SHOW shared_preload_libraries" | grep pgaudit)

if [[ -z "$pgaudit_check" ]]; then
  echo "pgaudit is not enabled"
  exit 1
fi

# Check if role, read, write, and ddl auditing are enabled
audit_check=$(sudo -u postgres psql -c "SHOW pgaudit.log" | grep -E "role|read|write|ddl")

if [[ -z "$audit_check" ]]; then
  echo "role, read, write, and ddl auditing are not enabled"
  exit 1
fi

exit 0

