
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214149
# Severity: medium

# Check the cn of the certificate
cn=$(openssl x509 -noout -subject -in client_cert | awk -F'=' '{print $NF}')

# Check if the cn matches any user in PostgreSQL
user_exists=$(sudo -u postgres psql -c "\du" | grep -w $cn)

# Check if user name mapping is used
map_exists=$(sudo -u postgres grep "map" ${PGDATA?}/pg_hba.conf)

# Check user name mappings in pg_ident.conf
user_mapping_exists=$(sudo -u postgres cat ${PGDATA?}/pg_ident.conf | grep -w $cn)

if [[ -z "$user_exists" && -z "$map_exists" && -z "$user_mapping_exists" ]]; then
  echo "STIG Finding ID: V-214149 - The cn attribute of the certificate does not match the requested database user name and no user mapping is used."
  exit 1
else
  exit 0
fi

