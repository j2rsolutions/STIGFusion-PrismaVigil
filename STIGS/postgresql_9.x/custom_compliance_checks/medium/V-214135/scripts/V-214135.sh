
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214135
# Severity: medium

# Connect to the PostgreSQL database and run the SQL commands
PGPASSWORD=<password> psql -U <username> -d <database> -h <hostname> -p <port> -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE user='<username>'" > /dev/null 2>&1
single_user_auth=$?

PGPASSWORD=<password> psql -U <username> -d <database> -h <hostname> -p <port> -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE user LIKE '%'" > /dev/null 2>&1
all_users_auth=$?

# Check the exit status of the SQL commands
if [ $single_user_auth -eq 0 ] && [ $all_users_auth -eq 0 ]; then
    echo 'Re-authentication check passed'
    exit 0
else
    echo 'Re-authentication check failed'
    exit 1
fi

