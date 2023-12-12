
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214155
# Severity: medium

# Check if pgaudit is enabled
pgaudit_enabled=$(sudo -u postgres psql -c "SHOW shared_preload_libraries" | grep pgaudit)

if [ -z "$pgaudit_enabled" ]; then
  echo "pgaudit is not enabled"
  exit 1
fi

# Check if role, read, write, and ddl auditing are enabled
auditing_enabled=$(sudo -u postgres psql -c "SHOW pgaudit.log" | grep -E "role|read|write|ddl")

if [ -z "$auditing_enabled" ]; then
  echo "role, read, write, and ddl auditing are not enabled"
  exit 1
fi

exit 0

