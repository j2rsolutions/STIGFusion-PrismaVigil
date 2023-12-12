
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214094
# Severity: medium

# Create a role 'bob'
sudo su - postgres -c "psql -c \"CREATE ROLE bob\""

# Attempt to retrieve information from the pg_authid table
sudo su - postgres -c "psql -c \"SET ROLE bob; SELECT * FROM pg_authid\""

# Check the latest log for the error message
log_file=$(ls -t ${PGDATA?}/pg_log/ | head -1)
error_message=$(sudo su - postgres -c "cat ${PGDATA?}/pg_log/$log_file | grep 'permission denied for relation pg_authid'")

if [[ -z "$error_message" ]]; then
  echo "Audit records are not produced when PostgreSQL denies retrieval of privileges/permissions/role memberships"
  exit 1
else
  echo "Audit records are produced when PostgreSQL denies retrieval of privileges/permissions/role memberships"
  exit 0
fi

