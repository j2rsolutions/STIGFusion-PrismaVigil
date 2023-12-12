
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214054
# Severity: medium

# Check the permissions of configuration files for the database
sudo su - postgres -c "find ${PGDATA?} ! -user postgres -type f -exec echo 'test permission failure' {} \; -exec exit 1 \;"

# Check the permissions on the shared libraries for PostgreSQL
for dir in bin include lib share
do
  sudo find /usr/pgsql-${PGVER?}/$dir ! -user root -type f -exec echo 'test permission failure' {} \; -exec exit 1 \;
done

exit 0

