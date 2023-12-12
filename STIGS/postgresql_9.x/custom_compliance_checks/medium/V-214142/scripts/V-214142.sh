
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214142
# Severity: medium

# Check if postgresql is installed
if ! command -v psql &> /dev/null
then
    echo "postgresql is not installed"
    exit 1
fi

# Check log_line_prefix
log_line_prefix=$(sudo -u postgres psql -c "SHOW log_line_prefix" | grep "%m")

if [ -z "$log_line_prefix" ]
then
    echo "log_line_prefix does not contain %m"
    exit 1
else
    echo "log_line_prefix contains %m"
    exit 0
fi

