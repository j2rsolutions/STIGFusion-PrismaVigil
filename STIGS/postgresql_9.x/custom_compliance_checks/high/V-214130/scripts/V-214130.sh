
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214130
# Severity: high

# Check if password encryption is enabled
password_encryption=$(sudo -u postgres psql -c "SHOW password_encryption" | grep 'on')

if [[ -z "$password_encryption" ]]; then
  echo "Password encryption is not enabled"
  exit 1
fi

# Check if any passwords have been stored without being hashed and salted
plaintext_password=$(sudo -u postgres psql -x -c "SELECT * FROM pg_shadow" | grep 'plaintext')

if [[ -n "$plaintext_password" ]]; then
  echo "Plaintext password found"
  exit 1
fi

exit 0

