
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214056
# Severity: high

# Check if any entries in pg_hba.conf use the auth_method "password"
if sudo su - postgres -c "cat ${PGDATA?}/pg_hba.conf" | grep -q "password"; then
    echo "V-214056: PostgreSQL is using password authentication method"
    exit 1
else
    exit 0
fi

