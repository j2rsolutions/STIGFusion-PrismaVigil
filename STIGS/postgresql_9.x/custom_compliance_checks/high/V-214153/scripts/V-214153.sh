
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214153
# Severity: high

openssl_version=$(openssl version)
if [[ $openssl_version != *"fips"* ]]; then
  echo 'FIPS not included in openssl version'
  exit 1
fi
exit 0

