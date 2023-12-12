
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-220321
# Severity: medium

# Check if PostgreSQL is configured to use SSL
SSL_STATUS=$(sudo -u postgres psql -c "SHOW ssl" | grep 'off')

# If SSL is off, this is a finding
if [[ $SSL_STATUS == 'off' ]]; then
  echo 'V-220321: PostgreSQL is not using NSA-approved cryptography'
  exit 1
fi

# Consult network administration staff to determine whether the server is protected by NSA-approved encrypting devices.
# This part of the check is manual and cannot be automated.
echo 'V-220321: Please manually verify if the server is protected by NSA-approved encrypting devices.'
exit 0

