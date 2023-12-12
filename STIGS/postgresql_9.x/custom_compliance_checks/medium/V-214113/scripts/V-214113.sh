
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214113
# Severity: medium

# Check if SSL is enabled
SSL_ENABLED=$(sudo -u postgres psql -c "SHOW ssl" | grep 'on')
if [[ -z "$SSL_ENABLED" ]]; then
  echo "SSL is not enabled"
  exit 1
fi

# Check if hostssl entries contain clientcert=1
HOSTSSL_ENTRIES=$(sudo -u postgres grep hostssl ${PGDATA?}/pg_hba.conf | grep 'clientcert=1')
if [[ -z "$HOSTSSL_ENTRIES" ]]; then
  echo "hostssl entries do not contain clientcert=1"
  exit 1
fi

# Check if any uncommented lines are not of TYPE "hostssl" and do not include the "clientcert=1" authentication option
UNCOMMENTED_LINES=$(sudo -u postgres grep -v '^#' ${PGDATA?}/pg_hba.conf | grep -v 'hostssl' | grep -v 'clientcert=1')
if [[ -n "$UNCOMMENTED_LINES" ]]; then
  echo "Uncommented lines are not of TYPE hostssl and do not include the clientcert=1 authentication option"
  exit 1
fi

# If all checks pass, exit with 0
exit 0

