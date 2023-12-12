
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214087
# Severity: medium

# Attempt to log into the Postgres database with a non-existent user
psql -d postgres -U non_existent_user > /dev/null 2>&1

# Check the PostgreSQL log for a FATAL connection audit trail
if sudo -u postgres grep -q "FATAL: role \"non_existent_user\" does not exist" ${PGDATA?}/pg_log/postgresql-*.log; then
    echo "Audit record generated for failed login attempt"
    exit 0
else
    echo "No audit record generated for failed login attempt"
    exit 1
fi

