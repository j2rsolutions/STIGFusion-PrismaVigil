
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214077
# Severity: medium

# Check if PostgreSQL is installed
if ! command -v psql &> /dev/null
then
    echo "PostgreSQL is not installed, exiting with code 0"
    exit 0
fi

# Check if the PostgreSQL audit extension (pgAudit) is installed
if ! psql -U postgres -c "\dx" | grep -q pgaudit
then
    echo "pgAudit is not installed, exiting with code 1"
    exit 1
fi

# Check if the organization-defined additional information is in the audit records
# Replace "additional_info" with the actual additional information defined by the organization
if ! psql -U postgres -c "SELECT * FROM pgaudit.log WHERE parameter = 'additional_info';" | grep -q "additional_info"
then
    echo "Additional information is not contained in the audit records, exiting with code 1"
    exit 1
fi

echo "All checks passed, exiting with code 0"
exit 0

