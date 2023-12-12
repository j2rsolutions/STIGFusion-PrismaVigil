
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214116
# Severity: medium

# Check if postgresql is installed
if ! command -v psql &> /dev/null
then
    echo "postgresql is not installed"
    exit 1
fi

# Check log_line_prefix setting
log_line_prefix=$(sudo -u postgres psql -c "SHOW log_line_prefix" | awk 'NR==3')

if [[ $log_line_prefix == *"%m"* && $log_line_prefix == *"%u"* && $log_line_prefix == *"%d"* && $log_line_prefix == *"%p"* && $log_line_prefix == *"%r"* && $log_line_prefix == *"%a"* ]]; then
    echo "log_line_prefix setting is correct"
    exit 0
else
    echo "log_line_prefix setting is incorrect"
    exit 1
fi

