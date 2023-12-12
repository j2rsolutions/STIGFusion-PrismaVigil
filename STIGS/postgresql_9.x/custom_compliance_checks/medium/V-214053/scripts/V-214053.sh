
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214053
# Severity: medium

# Connect to the PostgreSQL database and run the SQL command
output=$(psql -U postgres -d mydatabase -c "SELECT current_setting('client_min_messages');")

# Check if client_min_messages is not set to error
if [[ $output != *"error"* ]]; then
  echo "client_min_messages is not set to error"
  exit 1
fi

exit 0

