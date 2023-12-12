
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214117
# Severity: high

fips_enabled=$(cat /proc/sys/crypto/fips_enabled)

if [ "$fips_enabled" -ne 1 ]; then
    echo "FIPS is not enabled"
    exit 1
fi

exit 0

