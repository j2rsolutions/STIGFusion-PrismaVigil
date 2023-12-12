
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214084
# Severity: medium

# Check for multiple versions of postgres
versions=$(rpm -qa | grep postgres | wc -l)

if [ $versions -gt 1 ]; then
  echo "Multiple versions of postgres are installed"
  exit 1
else
  echo "Only one version of postgres is installed"
  exit 0
fi

