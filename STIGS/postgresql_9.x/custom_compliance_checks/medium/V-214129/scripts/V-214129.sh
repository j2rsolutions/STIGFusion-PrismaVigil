
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214129
# Severity: medium

# Assuming the schema name is 'public' and table name is 'users'
SCHEMA_NAME='public'
TABLE_NAME='users'

# Check if postgresql is installed
if ! command -v psql &> /dev/null
then
    echo "PostgreSQL is not installed. Exiting with code 1."
    exit 1
fi

# Check if security labels are implemented on the specified table
SECURITY_LABELS=$(sudo -u postgres psql -c "\d+ ${SCHEMA_NAME}.${TABLE_NAME}" | grep 'Security labels')

if [[ -z "$SECURITY_LABELS" ]]; then
    echo "Security labeling is not implemented or does not reliably maintain labels on information in process."
    exit 1
else
    echo "Security labeling is implemented and maintains labels on information in process."
    exit 0
fi

