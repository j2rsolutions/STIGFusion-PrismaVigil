
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214120
# Severity: high

# Check if pgcrypto is installed on PostgreSQL
PGCRYPTO_CHECK=$(sudo -u postgres psql -c "SELECT * FROM pg_available_extensions where name='pgcrypto'" | grep -c pgcrypto)

# Check if disk-level encryption is enabled
DISK_ENCRYPTION_CHECK=$(lsblk -d -o name,rota,type,mountpoint | grep -c crypt)

# If data in the database requires encryption and pgcrypto is not available, exit with 1
if [ "$PGCRYPTO_CHECK" -eq 0 ]; then
  echo 'pgcrypto extension is not available'
  exit 1
fi

# If disk or filesystem requires encryption and it is not enabled, exit with 1
if [ "$DISK_ENCRYPTION_CHECK" -eq 0 ]; then
  echo 'Disk-level encryption is not enabled'
  exit 1
fi

# If both checks pass, exit with 0
exit 0

