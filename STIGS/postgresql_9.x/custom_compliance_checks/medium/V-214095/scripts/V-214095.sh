
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214095
# Severity: medium

# Create roles joe and bob
sudo su - postgres -c "psql -c \"CREATE ROLE joe LOGIN\""
sudo su - postgres -c "psql -c \"CREATE ROLE bob LOGIN\""

# Attempt to alter role joe as bob
sudo su - postgres -c "psql -c \"SET ROLE bob; ALTER ROLE joe NOLOGIN;\""

# Check the logs for the error message
LOG_CHECK=$(sudo su - postgres -c "cat ${PGDATA?}/pg_log/$(ls -t ${PGDATA?}/pg_log/ | head -1) | grep 'ERROR: permission denied to alter role'")

if [[ -z "$LOG_CHECK" ]]; then
    echo "Audit logs not generated for unsuccessful attempts to delete privileges/permissions"
    exit 1
else
    echo "Audit logs generated for unsuccessful attempts to delete privileges/permissions"
    exit 0
fi

