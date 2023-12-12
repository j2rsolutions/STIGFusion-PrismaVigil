
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214068
# Severity: medium

# Check log_file_mode in postgresql.conf
log_file_mode=$(sudo -u postgres grep "log_file_mode" ${PGDATA?}/postgresql.conf)

if [[ $log_file_mode != *"0600"* ]]; then
  echo "log_file_mode permissions are not 0600"
  exit 1
fi

# Check log_directory in postgresql.conf
log_directory=$(sudo -u postgres grep "log_directory" ${PGDATA?}/postgresql.conf)

# Extract the directory path
log_directory_path=$(echo $log_directory | cut -d '=' -f2 | xargs)

# Check the permissions of the logs
log_permissions=$(sudo -u postgres ls -la ${PGDATA?}/pg_log)

if [[ $log_permissions != *"-rw