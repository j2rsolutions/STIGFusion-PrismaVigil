
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214061
# Severity: medium

# Check if postgresql is installed
if ! command -v psql &> /dev/null
then
    echo "postgresql is not installed"
    exit 1
fi

# Check if postgres user exists
if ! id -u postgres > /dev/null 2>&1; then
    echo "postgres user does not exist"
    exit 1
fi

# Get the list of all roles in the database
roles=$(sudo -u postgres psql -c "\du" | awk '{print $1}' | tail -n +4 | head -n -2)

# Check if roles are unique
if [[ $(echo "$roles" | sort | uniq -d | wc -l) -ne 0 ]]; then
    echo "Roles are not unique"
    exit 1
fi

echo "Roles are unique"
exit 0

