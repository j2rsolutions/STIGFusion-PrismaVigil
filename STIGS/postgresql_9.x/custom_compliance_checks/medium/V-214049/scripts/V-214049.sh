
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214049
# Severity: medium

# This script checks if audit records exist without the outcome of the event that occurred.

# Assuming that the PGDATA environment variable is set and postgres is the database administrator

# Create a table, insert a value, alter the table and update the table
sudo -u postgres psql -c "CREATE TABLE stig_test(id INT); INSERT INTO stig_test(id) VALUES (0); ALTER TABLE stig_test ADD COLUMN name text; UPDATE stig_test SET id = 1 WHERE id = 0;"

# As a user without access to the stig_test table, try to insert a value, alter the table and update the table
# These commands should generate errors
sudo -u postgres psql -c "INSERT INTO stig_test(id) VALUES (1); ALTER TABLE stig_test DROP COLUMN name; UPDATE stig_test SET id = 0 WHERE id = 1;"

# As the database administrator, drop the test table
sudo -u postgres psql -c "DROP TABLE stig_test;"

# Check the latest log file for errors
errors=$(sudo -u postgres cat ${PGDATA?}/pg_log/$(ls -t ${PGDATA?}/pg_log/ | head -1) | grep -E "ERROR: permission denied for relation stig_test|ERROR: must be owner of relation stig_test")

# If audit records exist without the outcome of the event that occurred, exit with 1
if [[ -z "$errors" ]]; then
    echo "Audit records exist without the outcome of the event that occurred."
    exit 1
else
    echo "Audit records include the outcome of the event that occurred."
    exit 0
fi

