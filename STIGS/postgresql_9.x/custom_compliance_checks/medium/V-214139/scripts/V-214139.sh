
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214139
# Severity: medium

# Check if pgcrypto is installed on PostgreSQL
PGCRYPTO_CHECK=$(sudo -u postgres psql -c "SELECT * FROM pg_available_extensions where name='pgcrypto'" | grep pgcrypto)

if [[ -z "$PGCRYPTO_CHECK" ]]; then
  echo "pgcrypto is not installed on PostgreSQL"
  exit 1
fi

# Check if filesystem and/or disk-level encryption is required and is in use
# This is a manual check and needs to be verified by the system owner, DBA, and SA
echo "V-214139: Verify with system owner, DBA, and SA if filesystem and/or disk-level encryption is required and is in use."
exit 0

