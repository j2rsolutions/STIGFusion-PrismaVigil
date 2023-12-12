
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214103
# Severity: medium

# Check if log_connections and log_disconnections are enabled
log_connections=$(sudo -u postgres psql -c "SHOW log_connections" | grep on)
log_disconnections=$(sudo -u postgres psql -c "SHOW log_disconnections" | grep on)

if [[ -z "$log_connections" || -z "$log_disconnections" ]]; then
  echo "log_connections or log_disconnections is off"
  exit 1
fi

# Check if log_line_prefix contains sufficient information
log_line_prefix=$(sudo -u postgres psql -c "SHOW log_line_prefix" | grep "%m %u %d %c")

if [[ -z "$log_line_prefix" ]]; then
  echo "log_line_prefix does not contain at least %m %u %d %c"
  exit 1
fi

exit 0

