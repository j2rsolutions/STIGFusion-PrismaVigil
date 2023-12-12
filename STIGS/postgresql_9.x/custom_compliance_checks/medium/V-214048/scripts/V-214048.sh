
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214048
# Severity: medium

# Check if postgresql is installed
if ! command -v psql &> /dev/null
then
    echo "postgresql is not installed"
    exit 1
fi

# Get the port postgresql is running on
port=$(psql -t -c "SHOW port")

# Check if the port is prohibited
if [[ $port -eq 5432 ]]; then
    echo "Port configuration is prohibited"
    exit 1
fi

exit 0

