
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214111
# Severity: medium

# Check if a CRL file exists
CRL_FILE=$(sudo -u postgres psql -c "SHOW ssl_crl_file" | sed -n 3p | xargs)

if [[ -z "$CRL_FILE" ]]; then
  echo "No CRL file set in postgresql.conf"
  exit 1
fi

# Check if the CRL file exists
if [[ ! -f "$CRL_FILE" ]]; then
  echo "CRL file does not exist"
  exit 1
fi

# Check if hostssl entries in pg_hba.conf have "cert" and "clientcert=1" enabled
HOSTSSL_ENTRIES=$(sudo -u postgres grep hostssl ${PGDATA?}/pg_hba.conf)

if [[ ! "$HOSTSSL_ENTRIES" =~ "cert" ]] || [[ ! "$HOSTSSL_ENTRIES" =~ "clientcert=1" ]]; then
  echo "hostssl entries do not contain cert or clientcert=1"
  exit 1
fi

# If all checks pass, exit with 0
exit 0

