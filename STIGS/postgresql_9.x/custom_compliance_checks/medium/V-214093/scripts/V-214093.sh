
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214093
# Severity: medium

# Assuming PGDATA is set and postgresql is installed
# Create a test table, enable row level security, and create a policy
sudo su - postgres -c "psql -c \"CREATE TABLE stig_test(id INT)\""
sudo su - postgres -c "psql -c \"ALTER TABLE stig_test ENABLE ROW LEVEL SECURITY\""
sudo su - postgres -c "psql -c \"CREATE POLICY lock_table ON stig_test USING ('postgres' = current_user)\""

# Drop the policy and disable row level security
sudo su - postgres -c "psql -c \"DROP POLICY lock_table ON stig_test\""
sudo su - postgres -c "psql -c \"ALTER TABLE stig_test DISABLE ROW LEVEL SECURITY\""

# Check the latest log for the audit records
audit_records=$(sudo su - postgres -c "cat ${PGDATA?}/pg_log/$(ls -t ${PGDATA?}/pg_log/ | head -1) | grep -E 'DROP POLICY|DISABLE ROW LEVEL SECURITY'")

if [[ -z "$audit_records" ]]; then
    echo "No audit records found for security objects deletion"
    exit 1
else
    echo "Audit records found for security objects deletion"
    exit 0
fi

