
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214090
# Severity: medium

# Create a role
sudo su - postgres -c "psql -c \"CREATE ROLE bob\""

# Grant then revoke privileges from the role
sudo su - postgres -c "psql -c \"GRANT CONNECT ON DATABASE postgres TO bob\""
sudo su - postgres -c "psql -c \"REVOKE CONNECT ON DATABASE postgres FROM bob\""

# Verify the events were logged
audit_log=$(sudo su - postgres -c "cat ${PGDATA?}/pg_log/$(ls -t ${PGDATA?}/pg_log/ | head -1)")

grant_log=$(echo "$audit_log" | grep "GRANT CONNECT ON DATABASE postgres TO bob")
revoke_log=$(echo "$audit_log" | grep "REVOKE CONNECT ON DATABASE postgres FROM bob")

if [[ -z "$grant_log" || -z "$revoke_log" ]]; then
    echo "V-214090 - Audit records are not produced when privileges/permissions/role memberships are added or removed."
    exit 1
else
    exit 0
fi

