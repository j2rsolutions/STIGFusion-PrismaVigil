
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214151
# Severity: medium

# Check if the PGDATA environment variable is set
if [ -z "$PGDATA" ]; then
    echo "PGDATA environment variable is not set."
    exit 1
fi

# Check file ownership and permissions
find $PGDATA -not -user postgres -exec echo 'File ownership failure' {} \; -quit -o \
    -not -perm -u=rwX -exec echo 'File permission failure' {} \; -quit

if [ $? -eq 0 ]; then
    exit 0
else
    exit 1
fi

