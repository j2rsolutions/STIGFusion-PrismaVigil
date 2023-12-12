
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214147
# Severity: medium

# Check if PostgreSQL is installed
if ! command -v psql &> /dev/null
then
    echo "PostgreSQL is not installed. Exiting with code 0."
    exit 0
fi

# Check if PostgreSQL is configured for automatic session termination
PG_TERMINATION_SETTING=$(psql -U postgres -c "SHOW idle_in_transaction_session_timeout;" | grep -o '[0-9]\+')

if [ -z "$PG_TERMINATION_SETTING" ]
then
    echo "PostgreSQL is not configured for automatic session termination. Exiting with code 1."
    exit 1
else
    echo "PostgreSQL is configured for automatic session termination. Exiting with code 0."
    exit 0
fi

