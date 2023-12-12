
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214145
# Severity: medium

# Check if PostgreSQL is configured to use ssl
SSL_STATUS=$(sudo -u postgres psql -c "SHOW ssl" | grep 'on')

if [ "$SSL_STATUS" != "on" ]; then
  echo "PostgreSQL is not configured to use SSL"
  exit 1
else
  echo "PostgreSQL is configured to use SSL"
  exit 0
fi

