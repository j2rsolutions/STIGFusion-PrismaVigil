
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214059
# Severity: medium

# Check the total amount of connections allowed by the database
MAX_CONNECTIONS=$(sudo -u postgres psql -c "SHOW max_connections" | awk 'NR==3{print $1}')

# Replace the value 100 with the maximum connections allowed by your organization
if [ "$MAX_CONNECTIONS" -gt 100 ]; then
  echo "Total amount of connections is greater than documented by the organization"
  exit 1
fi

# Check the amount of connections allowed for each role
ROLE_CONNECTIONS=$(sudo -u postgres psql -c "SELECT rolname, rolconnlimit from pg_authid")

# Replace the value 10 with the maximum connections allowed per role by your organization
while read -r line; do
  ROLE=$(echo "$line" | awk '{print $1}')
  CONNECTIONS=$(echo "$line" | awk '{print $2}')
  if [ "$CONNECTIONS" -gt 10 ] || [ "$CONNECTIONS" -eq -1 ]; then
    echo "Role $ROLE has more connections configured than documented by the organization"
    exit 1
  fi
done <<< "$ROLE_CONNECTIONS"

exit 0

