
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214106
# Severity: medium

# Switch to postgres user and create a new role
sudo su - postgres -c "psql -c \"CREATE ROLE bob\""

# Switch to bob role and attempt to execute privileged activity
sudo su - postgres -c "psql -c \"SET ROLE bob; CREATE ROLE stig_test SUPERUSER\""
sudo su - postgres -c "psql -c \"SET ROLE bob; CREATE ROLE stig_test CREATEDB\""
sudo su - postgres -c "psql -c \"SET ROLE bob; CREATE ROLE stig_test CREATEROLE\""
sudo su - postgres -c "psql -c \"SET ROLE bob; CREATE ROLE stig_test CREATEUSER\""

# Check the latest log for audit records
audit_records=$(sudo su - postgres -c "cat ${PGDATA?}/pg_log/$(ls -t ${PGDATA?}/pg_log/ | head -1) | grep 'ERROR: '")

# If audit records are not produced, exit with 1
if [[ -z "$audit_records" ]]; then
  echo "No audit records found."
  exit 1
else
  echo "Audit records found."
  exit 0
fi

