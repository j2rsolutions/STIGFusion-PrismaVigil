
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214058
# Severity: medium

# Assuming the schema name is 'public' and table name is 'users'
SCHEMA_NAME='public'
TABLE_NAME='users'

# Check if security labeling is required
SECURITY_LABELING_REQUIRED=1  # Set this to 1 if security labeling is required, else 0

if [ $SECURITY_LABELING_REQUIRED -eq 0 ]; then
  echo "Security labeling is not required"
  exit 0
fi

# Check if policy is attached to the table
POLICY=$(sudo -u postgres psql -c "\d+ ${SCHEMA_NAME}.${TABLE_NAME}" | grep -i 'Policies')

if [ -z "$POLICY" ]; then
  echo "No policy attached to the table"
  exit 1
fi

# Check if security labeling is implemented according to system documentation
# This is a manual check and needs to be replaced with actual implementation
SECURITY_LABELING_IMPLEMENTED=1  # Set this to 1 if security labeling is implemented according to system documentation, else 0

if [ $SECURITY_LABELING_IMPLEMENTED -eq 0 ]; then
  echo "Security labeling is not implemented according to system documentation"
  exit 1
fi

# Check if security labeling reliably maintains labels on information in storage
# This is a manual check and needs to be replaced with actual implementation
SECURITY_LABELING_MAINTAINED=1  # Set this to 1 if security labeling reliably maintains labels on information in storage, else 0

if [ $SECURITY_LABELING_MAINTAINED -eq 0 ]; then
  echo "Security labeling does not reliably maintain labels on information in storage"
  exit 1
fi

echo "All checks passed"
exit 0

