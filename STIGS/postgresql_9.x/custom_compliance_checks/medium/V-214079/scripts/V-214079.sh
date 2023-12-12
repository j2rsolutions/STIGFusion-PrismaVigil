
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214079
# Severity: medium

# Attempt to create a table with incorrect syntax
sudo su - postgres -c "psql -c \"CREAT TABLEincorrect_syntax(id INT)\""

# Check if the error was logged
ERROR_LOG=$(sudo su - postgres -c "cat ~/${PGVER?}/data/pg_log/postgresql-*.log | grep 'ERROR: syntax error at or near \"CREAT\"'")

if [[ -z "$ERROR_LOG" ]]; then
    echo "V-214079: PostgreSQL is not logging syntax errors"
    exit 1
else
    echo "V-214079: PostgreSQL is logging syntax errors"
    exit 0
fi

