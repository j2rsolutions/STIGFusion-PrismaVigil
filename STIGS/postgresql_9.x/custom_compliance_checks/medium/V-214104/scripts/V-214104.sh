
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214104
# Severity: medium

# Check if pgaudit is enabled
pgaudit_enabled=$(sudo -u postgres psql -c "SHOW shared_preload_libraries" | grep -c "pgaudit")

if [ $pgaudit_enabled -eq 0 ]; then
    echo "pgaudit is not enabled"
    exit 1
fi

# Check if role, read, write, and ddl auditing are enabled
auditing_enabled=$(sudo -u postgres psql -c "SHOW pgaudit.log" | grep -c "role, read, write, ddl")

if [ $auditing_enabled -eq 0 ]; then
    echo "role, read, write, and ddl auditing are not enabled"
    exit 1
fi

exit 0

