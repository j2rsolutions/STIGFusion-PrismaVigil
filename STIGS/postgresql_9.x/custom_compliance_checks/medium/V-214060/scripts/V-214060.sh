
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214060
# Severity: medium

# Check database permissions
sudo su - postgres -c "psql -c '\dp *.*'" | grep -q -v 'r\|w\|a'
if [ $? -eq 0 ]; then
  echo 'Database permissions check failed'
  exit 1
fi

# Check filesystem permissions
ls -la ${PGDATA?} | grep -q -v 'r\|w\|x'
if [ $? -eq 0 ]; then
  echo 'Filesystem permissions check failed'
  exit 1
fi

exit 0

