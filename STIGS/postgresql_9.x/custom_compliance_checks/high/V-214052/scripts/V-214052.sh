
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214052
# Severity: high

# Check if PGDATA environment variable is set
if [ -z "$PGDATA" ]; then
    echo "PGDATA environment variable is not set. Please set it and rerun the script."
    exit 1
fi

# Check pg_hba.conf file for any records with a different auth-method than gss, sspi, or ldap
if grep -Pvq '^(#.*|\s*)$' $PGDATA/pg_hba.conf | grep -Pvq '(gss|sspi|ldap)'; then
    echo "There are records with a different auth-method than gss, sspi, or ldap in pg_hba.conf"
    exit 1
else
    echo "All records in pg_hba.conf use an auth-method of gss, sspi, or ldap"
    exit 0
fi

