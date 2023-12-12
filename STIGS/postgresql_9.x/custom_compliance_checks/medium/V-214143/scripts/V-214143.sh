
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214143
# Severity: medium

# Check if PGDATA is owned by postgres:postgres and files cannot be accessed by others
PGDATA_OWNER=$(stat -c '%U:%G' ${PGDATA?})
if [[ "$PGDATA_OWNER" != "postgres:postgres" ]] || [[ $(stat -c %a ${PGDATA?}) -gt 750 ]]; then
  echo 'PGDATA ownership or permission failure'
  exit 1
fi

# Check if pgsql shared objects and compiled binaries are owned by root:root
for dir in /usr/pgsql-${PGVER?}/bin /usr/pgsql-${PGVER?}/include /usr/pgsql-${PGVER?}/lib /usr/pgsql-${PGVER?}/share; do
  if [[ $(stat -c '%U:%G' $dir) != "root:root" ]]; then
    echo 'pgsql directory ownership failure'
    exit 1
  fi
done

# If all checks pass, exit with 0
exit 0

