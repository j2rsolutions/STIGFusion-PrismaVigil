
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214098
# Severity: medium

# Create a schema, test_schema, create a table, test_table, within test_schema, and insert a value
sudo su - postgres -c "psql -c \"CREATE SCHEMA test_schema\""
sudo su - postgres -c "psql -c \"CREATE TABLE test_schema.test_table(id INT)\""
sudo su - postgres -c "psql -c \"INSERT INTO test_schema.test_table(id) VALUES (0)\""

# Create a role 'bob' and attempt to SELECT, INSERT, UPDATE, and DROP from the test table
sudo su - postgres -c "psql -c \"CREATE ROLE bob\""
sudo su - postgres -c "psql -c \"SET ROLE bob; SELECT * FROM test_schema.test_table\""
sudo su - postgres -c "psql -c \"SET ROLE bob; INSERT INTO test_schema.test_table VALUES (0)\""
sudo su - postgres -c "psql -c \"SET ROLE bob; UPDATE test_schema.test_table SET id = 1 WHERE id = 0\""
sudo su - postgres -c "psql -c \"SET ROLE bob; DROP TABLE test_schema.test_table\""
sudo su - postgres -c "psql -c \"SET ROLE bob; DROP SCHEMA test_schema\""

# Check if audit records are created for unsuccessful attempts at the specified access to the specified objects
audit_records=$(sudo su - postgres -c "cat ${PGDATA?}/pg_log/$(ls -t ${PGDATA?}/pg_log/ | head -1) | grep -E 'ERROR: permission denied for schema test_schema|ERROR: must be owner of schema test_schema'")

if [[ -z "$audit_records" ]]; then
  echo "No audit records found for unsuccessful attempts at the specified access to the specified objects"
  exit 1
else
  echo "Audit records found for unsuccessful attempts at the specified access to the specified objects"
  exit 0
fi

