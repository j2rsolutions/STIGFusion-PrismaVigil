
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214109
# Severity: medium

# Create a role 'bob' and a test table
sudo su - postgres -c "psql -c \"CREATE ROLE bob; CREATE TABLE test(id INT)\""

# Attempt to modify privileges as bob
sudo su - postgres -c "psql -c \"SET ROLE bob; GRANT ALL PRIVILEGES ON test TO bob;\""
sudo su - postgres -c "psql -c \"SET ROLE bob; REVOKE ALL PRIVILEGES ON test FROM bob;\""

# Check the logs for unsuccessful attempts
LOG_OUTPUT=$(sudo su - postgres -c "cat ${PGDATA?}/pg_log/$(ls -t ${PGDATA?}/pg_log/ | head -1) | grep 'ERROR: permission denied for relation test'")

if [[ $LOG_OUTPUT == *"ERROR: permission denied for relation test"* ]]; then
  echo "Audit logs are generated when unsuccessful attempts to modify privileges/permissions occur."
  exit 0
else
  echo "Audit logs are not generated when unsuccessful attempts to modify privileges/permissions occur."
  exit 1
fi

