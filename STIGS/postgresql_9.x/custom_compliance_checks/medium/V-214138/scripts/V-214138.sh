
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214138
# Severity: medium

# Check log_line_prefix setting
log_line_prefix=$(sudo -u postgres psql -c "SHOW log_line_prefix" | awk 'NR==3')

# Check log_connections and log_disconnections settings
log_connections=$(sudo -u postgres psql -c "SHOW log_connections" | awk 'NR==3')
log_disconnections=$(sudo -u postgres psql -c "SHOW log_disconnections" | awk 'NR==3')

# Check if log_line_prefix is empty
if [ -z "$log_line_prefix" ]; then
  echo "log_line_prefix is not set"
  exit 1
fi

# Check if log_connections and log_disconnections are off
if [ "$log_connections" == "off" ] && [ "$log_disconnections" == "off" ]; then
  echo "log_connections and log_disconnections are off"
  exit 1
fi

# If all checks pass, exit with 0
exit 0

