
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214080
# Severity: medium

# Check if PostgreSQL uses syslog
log_destination=$(sudo -u postgres psql -c "SHOW log_destination" | grep syslog)

# Check which log facility PostgreSQL is configured
syslog_facility=$(sudo -u postgres psql -c "SHOW syslog_facility")

# If PostgreSQL audit records are not written directly to or systematically transferred to a centralized log management system, exit with 1
if [[ -z "$log_destination" || -z "$syslog_facility" ]]; then
    echo "PostgreSQL audit records are not written directly to or systematically transferred to a centralized log management system"
    exit 1
fi

exit 0

