
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214127
# Severity: medium

# Check for superuser roles
SUPERUSER_ROLES=$(sudo -u postgres psql -t -c "\du" | grep -i superuser)
if [[ $SUPERUSER_ROLES ]]; then
  echo "Found superuser roles that should not exist"
  exit 1
fi

# Check for unapproved extensions
UNAPPROVED_EXTENSIONS=$(sudo -u postgres psql -t -c "SELECT * FROM pg_available_extensions WHERE installed_version IS NOT NULL")
if [[ $UNAPPROVED_EXTENSIONS ]]; then
  echo "Found unapproved extensions"
  exit 1
fi

# If no issues found, exit with 0
exit 0

