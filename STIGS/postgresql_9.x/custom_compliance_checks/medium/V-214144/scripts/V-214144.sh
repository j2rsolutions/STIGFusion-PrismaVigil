
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214144
# Severity: medium

# Check if PostgreSQL uses syslog
log_destination=$(sudo -u postgres psql -c "SHOW log_destination" | grep syslog)

if [ -z "$log_destination" ]; then
  echo "V-214144: PostgreSQL does not use syslog"
  exit 1
fi

# Check which log facility is configured
syslog_facility=$(sudo -u postgres psql -c "SHOW syslog_facility")

# Replace "facility" with the correct facility for your organization
if [ "$syslog_facility" != "facility" ]; then
  echo "V-214144: Wrong syslog facility is configured"
  exit 1
fi

# Check if PostgreSQL has a continuous network connection to the centralized log management system
# and if PostgreSQL audit records are transferred to the centralized log management system weekly or more often
# This is a manual check and needs to be replaced with the correct check for your organization
# echo "V-214144: Check if PostgreSQL has a continuous network connection to the centralized log management system and if PostgreSQL audit records are transferred to the centralized log management system weekly or more often"
# exit 0

# If all checks pass
exit 0

