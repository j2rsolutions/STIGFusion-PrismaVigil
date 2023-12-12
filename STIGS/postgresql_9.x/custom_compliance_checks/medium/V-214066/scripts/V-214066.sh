
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214066
# Severity: medium

# Check if PostgreSQL audit log space has run out
if grep -q "could not write to log file: No space left on device" /var/log/postgresql/postgresql-9.x-main.log; then
    echo "PostgreSQL ran out of audit log space"
    exit 1
else
    echo "No incidents of PostgreSQL running out of audit log space"
    exit 0
fi

