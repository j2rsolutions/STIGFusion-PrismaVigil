
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214088
# Severity: medium

# Check if the log file exists
if [ ! -f "${PGDATA?}/pg_log/postgresql-Tue.log" ]; then
    echo "Log file does not exist"
    exit 1
fi

# Check if connections are logged
grep -q "LOG: connection authorized" "${PGDATA?}/pg_log/postgresql-Tue.log"
if [ $? -ne 0 ]; then
    echo "Connections are not logged"
    exit 1
fi

# If the script has not exited by this point, the check has passed
exit 0

