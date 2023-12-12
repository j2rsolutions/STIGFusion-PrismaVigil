
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214089
# Severity: medium

# Create a test role
sudo su - postgres -c "psql -c \"CREATE ROLE bob\""

# Test if audit records are generated from unsuccessful attempts at modifying security objects
sudo su - postgres -c "psql -c \"SET ROLE bob; UPDATE pg_authid SET rolsuper = 't' WHERE rolname = 'bob';\""

# Verify that the denials were logged
LOG_OUTPUT=$(sudo su - postgres -c "cat ${PGDATA?}/pg_log/$(ls -t ${PGDATA?}/pg_log/ | head -1) | grep 'ERROR: permission denied for relation pg_authid'")

if [[ -z "$LOG_OUTPUT" ]]; then
  echo "Denials are not logged"
  exit 1
else
  echo "Denials are logged"
  exit 0
fi

