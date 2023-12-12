
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214107
# Severity: medium

# Check if pgaudit is enabled
pgaudit_check=$(sudo -u postgres psql -c "SHOW shared_preload_libraries" | grep pgaudit)

if [[ -z "$pgaudit_check" ]]; then
  echo "pgaudit is not enabled"
  exit 1
fi

# Check if role, read, write, and ddl auditing are enabled
audit_log_check=$(sudo -u postgres psql -c "SHOW pgaudit.log" | grep -E "role|read|write|ddl")

if [[ -z "$audit_log_check" ]]; then
  echo "role, read, write, and ddl auditing are not enabled"
  exit 1
fi

# Check if accessing the catalog is audited
log_catalog_check=$(sudo -u postgres psql -c "SHOW pgaudit.log_catalog" | grep on)

if [[ -z "$log_catalog_check" ]]; then
  echo "Accessing the catalog is not audited"
  exit 1
fi

# If all checks pass, exit with 0
exit 0

