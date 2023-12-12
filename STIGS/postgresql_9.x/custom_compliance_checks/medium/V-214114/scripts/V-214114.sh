
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214114
# Severity: medium

# Check if PostgreSQL is installed
if ! command -v psql &> /dev/null
then
    echo "PostgreSQL is not installed"
    exit 1
fi

# Define organization-defined auditable events
ORG_AUDIT_EVENTS="LOGIN,LOGOUT,DDL"

# Check if PostgreSQL is auditing the organization-defined auditable events
AUDIT_EVENTS=$(sudo -u postgres psql -c "SHOW rds.log_statement;" | grep -oP '(?<=rds.log_statement ).*')

if [[ $AUDIT_EVENTS == *"$ORG_AUDIT_EVENTS"* ]]; then
    echo "PostgreSQL is auditing the organization-defined auditable events"
    exit 0
else
    echo "PostgreSQL is not auditing the organization-defined auditable events"
    exit 1
fi

