
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214100
# Severity: medium

# Check if pgaudit.log contains "ddl, write, role"
pgaudit_log_content=$(sudo -u postgres psql -c "SHOW pgaudit.log" | grep "ddl, write, role")

if [[ -z "$pgaudit_log_content" ]]; then
  echo "pgaudit.log does not contain 'ddl, write, role'"
  exit 1
else
  echo "pgaudit.log contains 'ddl, write, role'"
  exit 0
fi

