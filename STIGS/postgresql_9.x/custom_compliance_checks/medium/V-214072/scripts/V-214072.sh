
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214072
# Severity: medium

# Check if the postgresql is installed
if ! command -v psql &> /dev/null
then
    echo "postgresql is not installed"
    exit 1
fi

# Check if the postgresql is running
if ! pgrep -x "postgres" > /dev/null
then
    echo "postgresql is not running"
    exit 1
fi

# Check if the real-time alert is enabled when auditing fails
AUDIT_LOG_FAILURE=$(sudo -u postgres psql -c "SHOW log_destination;" | grep 'syslog')

if [ -z "$AUDIT_LOG_FAILURE" ]
then
    echo "Real-time alert is not sent when auditing fails"
    exit 1
else
    echo "Real-time alert is sent when auditing fails"
    exit 0
fi

