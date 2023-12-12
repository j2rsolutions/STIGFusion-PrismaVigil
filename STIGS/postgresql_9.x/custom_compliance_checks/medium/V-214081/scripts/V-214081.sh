
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214081
# Severity: medium

# Check if postgresql is installed
if ! command -v psql &> /dev/null
then
    echo "postgresql is not installed"
    exit 1
fi

# Check access controls for pg_catalog and information_schema
PG_CATALOG_ACCESS=$(sudo -u postgres psql -t -c "\dp pg_catalog.*")
INFORMATION_SCHEMA_ACCESS=$(sudo -u postgres psql -t -c "\dp information_schema.*")

# Check ownership of PostgreSQL functions
PG_CATALOG_FUNC=$(sudo -u postgres psql -t -c "\df+ pg_catalog.*")
INFORMATION_SCHEMA_FUNC=$(sudo -u postgres psql -t -c "\df+ information_schema.*")

# Check if any user besides the database administrator(s) is listed in access privileges
if [[ $PG_CATALOG_ACCESS == *"="* ]] || [[ $INFORMATION_SCHEMA_ACCESS == *"="* ]] || [[ $PG_CATALOG_FUNC == *"="* ]] || [[ $INFORMATION_SCHEMA_FUNC == *"="* ]]; then
    echo "Access privileges violation"
    exit 1
fi

# If no violations, exit with 0
exit 0

