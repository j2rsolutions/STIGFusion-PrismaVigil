
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214092
# Severity: medium

# Check if log_connections is enabled
log_connections=$(sudo -u postgres psql -c "SHOW log_connections" | grep 'on')

# If log_connections is off, exit with 1
if [ -z "$log_connections" ]; then
  echo 'log_connections is off'
  exit 1
fi

# Get the latest log file
latest_log=$(ls -Art /var/lib/pgsql/9.6/data/pg_log/ | tail -n 1)

# Check if the previous connection to the database was logged
log_content=$(sudo -u postgres cat /var/lib/pgsql/9.6/data/pg_log/$latest_log | grep 'LOG:  connection authorized')

# If an audit record is not generated each time a user (or other principal) logs on or connects to PostgreSQL, exit with 1
if [ -z "$log_content" ]; then
  echo 'Audit record not generated for each connection'
  exit 1
fi

# If all checks pass, exit with 0
exit 0

