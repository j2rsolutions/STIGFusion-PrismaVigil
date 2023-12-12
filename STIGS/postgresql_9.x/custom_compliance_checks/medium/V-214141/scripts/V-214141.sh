
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214141
# Severity: medium

# Check if pg_log directory is owned by postgres user and group
pg_log_owner=$(ls -ld ${PGDATA?}/pg_log | awk '{print $3":"$4}')
if [ "$pg_log_owner" != "postgres:postgres" ]; then
  echo 'pg_log directory is not owned by postgres user and group'
  exit 1
fi

# Check if data directory is owned by postgres user and group
data_dir_owner=$(ls -ld ${PGDATA?} | awk '{print $3":"$4}')
if [ "$data_dir_owner" != "postgres:postgres" ]; then
  echo 'Data directory is not owned by postgres user and group'
  exit 1
fi

# Check if pgaudit installation is owned by root
pgaudit_owner=$(ls -ld /usr/pgsql-${PGVER?}/share/contrib/pgaudit | awk '{print $3":"$4}')
if [ "$pgaudit_owner" != "root:root" ]; then
  echo 'pgaudit installation is not owned by root'
  exit 1
fi

# Check if any role has "superuser" that should not
superuser_roles=$(sudo -u postgres psql -tAc "SELECT rolname FROM pg_roles WHERE rolsuper;")
for role in $superuser_roles
do
  if [ "$role" != "postgres" ]; then
    echo "Role $role should not have superuser privileges"
    exit 1
  fi
done

exit 0

