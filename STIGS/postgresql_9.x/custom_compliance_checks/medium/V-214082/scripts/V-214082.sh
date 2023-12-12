
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214082
# Severity: medium

# Check if postgresql is installed
if ! command -v psql &> /dev/null
then
    echo "postgresql is not installed"
    exit 1
fi

# Check if PGDATA is set
if [ -z "$PGDATA" ]
then
    echo "PGDATA is not set"
    exit 1
fi

# Switch to postgres user and check permissions
sudo su - postgres << 'EOF'
psql -c "CREATE ROLE bob; SET ROLE bob; SET pgaudit.role='test';" &> /dev/null
if grep -q "ERROR: permission denied to set parameter \"pgaudit.role\"" ${PGDATA}/pg_log/postgresql-*.log; then
    echo "Denial is logged"
else
    echo "Denial is not logged"
    exit 1
fi
EOF

# Check postgresql.conf permissions
if [ $(stat -c %U:%a ${PGDATA}/postgresql.conf) != "postgres:600" ]; then
    echo "postgresql.conf does not have correct permissions"
    exit 1
fi

exit 0

