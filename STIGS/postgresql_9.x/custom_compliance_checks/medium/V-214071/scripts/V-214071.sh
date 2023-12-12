
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214071
# Severity: medium

# Check if PGDATA is owned by postgres
if [ $(ls -ld $PGDATA | awk '{print $3}') != "postgres" ]; then
  echo "PGDATA is not owned by postgres"
  exit 1
fi

# Check if any role other than postgres has superuser access
sudo -u postgres psql -c "\du" | awk '{ if ($1 != "postgres" && $3 == "Superuser") { print $1 } }' | while read -r line
do
  if [ ! -z "$line" ]; then
    echo "Role $line has superuser access"
    exit 1
  fi
done

exit 0

