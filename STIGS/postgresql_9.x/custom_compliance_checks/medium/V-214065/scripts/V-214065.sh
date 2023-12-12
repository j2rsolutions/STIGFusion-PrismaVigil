
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214065
# Severity: medium

echo "Finding ID: V-214065"
echo "STIG Name: postgresql_9.x"
echo "Severity: medium"
echo "Manual Check: Review PostgreSQL source code (trigger procedures, functions) and application source code to identify cases of dynamic code execution. If dynamic code execution is employed without protective measures against code injection, this is a finding."
exit 0

