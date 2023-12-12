
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214110
# Severity: medium

# Create a role 'bob' and a test table
sudo su - postgres -c "psql -c \"CREATE ROLE bob; CREATE TABLE test(id INT);\""

# Set current role to bob and attempt to modify privileges
sudo su - postgres -c "psql -c \"SET ROLE bob; GRANT ALL PRIVILEGES ON test TO bob;\""

# Check the latest log for the unsuccessful attempt
log=$(sudo su - postgres -c "cat ${PGDATA?}/pg_log/$(ls -t ${PGDATA?}/pg_log/ | head -1) | grep 'ERROR: permission denied for relation test'")

if [[ -z "$log" ]]; then
  echo "STIG Finding ID: V-214110 - Audit logs are not generated when unsuccessful attempts to add privileges/permissions occur."
  exit 1
else
  echo "STIG Finding ID: V-214110 - Audit logs are generated when unsuccessful attempts to add privileges/permissions occur."
  exit 0
fi

