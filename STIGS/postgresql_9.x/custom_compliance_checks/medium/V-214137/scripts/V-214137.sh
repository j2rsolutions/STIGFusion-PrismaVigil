
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214137
# Severity: medium

ssl_ca_file=$(sudo -u postgres psql -c "SHOW ssl_ca_file" | grep -v "ssl_ca_file" | xargs)
ssl_cert_file=$(sudo -u postgres psql -c "SHOW ssl_cert_file" | grep -v "ssl_cert_file" | xargs)

if [[ -z "$ssl_ca_file" || -z "$ssl_cert_file" ]]; then
    echo "Database is not configured to use approved certificates"
    exit 1
else
    echo "Database is configured to use approved certificates"
    exit 0
fi

