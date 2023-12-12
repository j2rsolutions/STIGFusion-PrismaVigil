
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214083
# Severity: medium

# Check log_file_mode
log_file_mode=$(sudo -u postgres psql -c "SHOW log_file_mode" | grep -v "log_file_mode" | xargs)
if [[ $log_file_mode != "600" ]]; then
  echo "log_file_mode is not 600"
  exit 1
fi

# Check log_destination
log_destination=$(sudo -u postgres psql -c "SHOW log_destination" | grep -v "log_destination" | xargs)

# Check log files permissions
log_files=$(ls -l ${PGDATA?}/pg_log/ | awk '{print $1, $9}')
while read -r line; do
  permissions=$(echo $line | awk '{print $1}')
  if [[ $permissions != "-rw