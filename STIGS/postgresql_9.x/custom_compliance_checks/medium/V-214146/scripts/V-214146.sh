
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214146
# Severity: medium

# Check if PostgreSQL is installed
if ! command -v psql &> /dev/null
then
    echo "PostgreSQL is not installed"
    exit 1
fi

# Check if users are uniquely identified and authenticated
users=$(sudo -u postgres psql -c "\du" | awk '{print $1}' | tail -n +4 | head -n -2)
unique_users=$(echo "$users" | sort | uniq)

if [ "$users" != "$unique_users" ]
then
    echo "Organizational users are not uniquely identified and authenticated"
    exit 1
fi

# Check if every role has unique authentication requirements
auth_reqs=$(sudo -u postgres cat ${PGDATA?}/pg_hba.conf | grep -v '^#' | awk '{print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10}')
unique_auth_reqs=$(echo "$auth_reqs" | sort | uniq)

if [ "$auth_reqs" != "$unique_auth_reqs" ]
then
    echo "Every role does not have unique authentication requirements"
    exit 1
fi

# If the script has not exited by now, the check has passed
exit 0

