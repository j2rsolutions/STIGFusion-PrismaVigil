
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214069
# Severity: medium

# Check if postgresql is installed
if ! command -v psql &> /dev/null
then
    echo "postgresql is not installed"
    exit 1
fi

# Check the log_timezone setting
log_timezone=$(sudo -u postgres psql -c "SHOW log_timezone" | awk 'NR==3')

if [[ $log_timezone != "UTC" ]]
then
    echo "log_timezone is not set to UTC"
    exit 1
fi

exit 0

