
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214124
# Severity: medium

# Check if pgcrypto is installed on PostgreSQL
PGCRYPTO_CHECK=$(sudo -u postgres psql -c "SELECT * FROM pg_available_extensions where name='pgcrypto'" | grep pgcrypto)

# If pgcrypto is not installed, exit with 1
if [ -z "$PGCRYPTO_CHECK" ]; then
  echo "V-214124: pgcrypto is not installed on PostgreSQL"
  exit 1
fi

# If pgcrypto is installed, exit with 0
echo "V-214124: pgcrypto is installed on PostgreSQL"
exit 0

