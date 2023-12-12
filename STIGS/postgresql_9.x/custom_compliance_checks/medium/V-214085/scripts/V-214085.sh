
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214085
# Severity: medium

# Check if pgaudit.log contains "ddl, write, role"
PGAUDIT_LOG_CONTENT=$(sudo -u postgres psql -c "SHOW pgaudit.log" | grep "ddl, write, role")

if [[ -z "$PGAUDIT_LOG_CONTENT" ]]; then
  echo "pgaudit.log does not contain 'ddl, write, role'"
  exit 1
else
  echo "pgaudit.log contains 'ddl, write, role'"
  exit 0
fi

