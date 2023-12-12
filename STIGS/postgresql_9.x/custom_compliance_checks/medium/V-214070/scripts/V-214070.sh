
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214070
# Severity: medium

# Check client_min_messages setting
client_min_messages=$(sudo su - postgres -c "grep 'client_min_messages' ${PGDATA?}/postgresql.conf")
if [[ $client_min_messages == *"log"* ]] || [[ $client_min_messages == *"debug"* ]]; then
  echo "client_min_messages is set to LOG or DEBUG"
  exit 1
fi

# Check log_directory and log_file_mode settings
log_directory=$(sudo su - postgres -c "grep 'log_directory' ${PGDATA?}/postgresql.conf")
log_file_mode=$(sudo su - postgres -c "grep 'log_file_mode' ${PGDATA?}/postgresql.conf")

# Check log files permissions
log_files=$(ls -l $log_directory)
while read -r line; do
  permissions=$(echo $line | awk '{print $1}')
  owner=$(echo $line | awk '{print $3}')
  if [[ $permissions != "-rw