
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214112
# Severity: medium

# Check if postgresql is installed
if ! command -v psql &> /dev/null
then
    echo "postgresql is not installed, exiting with code 0"
    exit 0
fi

# Check the current log_line_prefix setting
log_line_prefix=$(sudo -u postgres psql -c "SHOW log_line_prefix" | awk 'NR==3')

# Check if log_line_prefix contains %m %u %d %s
if [[ $log_line_prefix == *"%m %u %d %s"* ]]; then
    echo "log_line_prefix contains %m %u %d %s"
    exit 0
else
    echo "log_line_prefix does not contain %m %u %d %s"
    exit 1
fi

