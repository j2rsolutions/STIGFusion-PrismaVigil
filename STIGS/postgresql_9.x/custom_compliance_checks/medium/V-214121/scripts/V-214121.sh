
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214121
# Severity: medium

# Check if PostgreSQL is installed
if ! command -v psql &> /dev/null
then
    echo "PostgreSQL is not installed"
    exit 1
fi

# Check for non-administrative users' ability to create, alter, or replace logic modules
sudo su - postgres -c "psql -c '\dp'" > /tmp/permissions.txt
sudo su - postgres -c "psql -c '\dn+'" >> /tmp/permissions.txt

# Check for any permissions that are not documented and approved
if grep -q -E "r|w|a|d|D|x|t|X|U|C|c|T|arwdDxt|\*" /tmp/permissions.txt; then
    echo "Non-administrative users have the ability to create, alter, or replace logic modules"
    exit 1
else
    echo "No non-administrative users have the ability to create, alter, or replace logic modules"
    exit 0
fi

