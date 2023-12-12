
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214086
# Severity: medium

# This script checks if the PostgreSQL database logs permission denials for each type of SQL command.

# Define the PostgreSQL log file
PG_LOG_FILE="${PGDATA?}/pg_log/$(ls -t ${PGDATA?}/pg_log | head -n 1)"

# Define the SQL commands to test
SQL_COMMANDS=(
  "CREATE TABLE stig_test_schema.test_table(id INT);"
  "INSERT INTO stig_test_schema.stig_test_table(id) VALUES (0);"
  "SELECT * FROM stig_test_schema.stig_test_table;"
  "ALTER TABLE stig_test_schema.stig_test_table ADD COLUMN name TEXT;"
  "UPDATE stig_test_schema.stig_test_table SET id=1 WHERE id=0;"
  "DELETE FROM stig_test_schema.stig_test_table WHERE id=0;"
  "PREPARE stig_test_plan(int) AS SELECT id FROM stig_test_schema.stig_test_table WHERE id=$1;"
  "DROP TABLE stig_test_schema.stig_test_table;"
)

# Execute each SQL command as role bob and check if the denial is logged
for SQL_COMMAND in "${SQL_COMMANDS[@]}"; do
  sudo su - postgres -c "psql -c \"SET ROLE bob; $SQL_COMMAND\""
  if ! grep -q "ERROR: permission denied for schema stig_test_schema" "$PG_LOG_FILE"; then
    echo "Denial for command '$SQL_COMMAND' was not logged"
    exit 1
  fi
done

# If all denials were logged, exit with 0
exit 0

