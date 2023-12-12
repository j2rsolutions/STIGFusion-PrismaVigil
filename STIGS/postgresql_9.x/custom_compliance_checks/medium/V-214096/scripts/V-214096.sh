
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214096
# Severity: medium

# Check if pgaudit is enabled
pgaudit_check=$(sudo -u postgres psql -c "SHOW shared_preload_libraries" | grep pgaudit)

if [[ -z "$pgaudit_check" ]]; then
  echo "pgaudit is not enabled"
  exit 1
fi

# List all role memberships for the database
role_memberships=$(sudo -u postgres psql -c "\du")

# Verify the query was logged
log_check=$(sudo -u postgres cat ${PGDATA?}/pg_log/$(ls -Art ${PGDATA?}/pg_log/ | tail -n 1) | grep "SELECT r.rolname, r.rolsuper, r.rolinherit, r.rolcreaterole, r.rolcreatedb, r.rolcanlogin, r.rolconnlimit, r.rolvaliduntil, ARRAY(SELECT b.rolname FROM pg_catalog.pg_auth_members m JOIN pg_catalog.pg_roles b ON (m.roleid = b.oid) WHERE m.member = r.oid) as memberof , r.rolreplication , r.rolbypassrls FROM pg_catalog.pg_roles r ORDER BY 1")

if [[ -z "$log_check" ]]; then
  echo "Audit records are not produced"
  exit 1
fi

exit 0

