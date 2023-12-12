
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214057
# Severity: high

# Check the privileges of all roles in the database
ROLE_PRIVILEGES=$(sudo -u postgres psql -c '\du')

# Check the configured privileges for tables and columns
TABLE_COLUMN_PRIVILEGES=$(sudo -u postgres psql -c '\dp')

# Check the configured authentication settings in pg_hba.conf
AUTH_SETTINGS=$(sudo -u postgres cat ${PGDATA?}/pg_hba.conf)

# Echo the results for manual review
echo "Role Privileges:"
echo "$ROLE_PRIVILEGES"
echo "Table and Column Privileges:"
echo "$TABLE_COLUMN_PRIVILEGES"
echo "Authentication Settings:"
echo "$AUTH_SETTINGS"

# Exit with a status code of 0
exit 0

