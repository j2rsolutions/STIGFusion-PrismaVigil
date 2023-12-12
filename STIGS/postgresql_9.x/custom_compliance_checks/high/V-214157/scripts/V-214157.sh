
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214157
# Severity: high

# Check if the OS is FIPS compliant
if [[ $(cat /proc/sys/crypto/fips_enabled) -eq 0 ]]; then
  echo "FIPS encryption is not enabled"
  exit 1
fi

# Check if PostgreSQL is installed on a CMVP compliant OS
OS_VERSION=$(uname -r)
if ! curl -s https://csrc.nist.gov/projects/cryptographic-module-validation-program/validated-modules | grep -q "$OS_VERSION"; then
  echo "PostgreSQL is not installed on a CMVP compliant OS"
  exit 1
fi

# If both checks pass, exit with 0
exit 0

