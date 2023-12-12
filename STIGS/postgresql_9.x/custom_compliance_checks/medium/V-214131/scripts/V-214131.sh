
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214131
# Severity: medium

# Check for SUPERUSER roles
SUPERUSER_ROLES=$(sudo -u postgres psql -c "\du" | grep SUPERUSER)
if [[ -n $SUPERUSER_ROLES ]]; then
  echo "Found SUPERUSER roles: $SUPERUSER_ROLES"
  exit 1
fi

# Check for update ("W") or create ("C") privileges on databases
DB_PRIVILEGES=$(sudo -u postgres psql -c "\l" | grep -E "W|C")
if [[ -n $DB_PRIVILEGES ]]; then
  echo "Found update or create privileges on databases: $DB_PRIVILEGES"
  exit 1
fi

# Check for update ("W") or create ("C") privileges on schemas
SCHEMA_PRIVILEGES=$(sudo -u postgres psql -c "\dn+" | grep -E "W|C")
if [[ -n $SCHEMA_PRIVILEGES ]]; then
  echo "Found update or create privileges on schemas: $SCHEMA_PRIVILEGES"
  exit 1
fi

# If no issues found, exit with 0
exit 0

