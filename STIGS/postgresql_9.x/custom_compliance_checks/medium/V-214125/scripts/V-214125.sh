
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214125
# Severity: medium

# Check PostgreSQL settings and existing audit records to verify information specific to the source (origin) of the event is being captured and stored with audit records.

log_line_prefix=$(sudo -u postgres psql -c "SHOW log_line_prefix" | awk 'NR==3')
log_hostname=$(sudo -u postgres psql -c "SHOW log_hostname" | awk 'NR==3')

if [[ $log_line_prefix == "" ]] || [[ $log_hostname == "off" ]]; then
    echo "Finding ID: V-214125 - The current settings do not provide enough information regarding the source of the event."
    exit 1
else
    echo "PostgreSQL settings are correctly configured."
    exit 0
fi

