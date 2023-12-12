
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214074
# Severity: medium

# This script checks if any PostgreSQL database objects are owned by unauthorized users.

# Please replace 'authorized_user' with the actual authorized username
authorized_user='authorized_user'

# Check the ownership of objects in the database
for object in "\dn *.*" "\dt *.*" "\ds *.*" "\dv *.*" "\df+ *.*"; do
  owner=$(sudo -u postgres psql -t -c "${object}" | awk -F "|" '{print $2}' | xargs)
  if [[ "${owner}" != "${authorized_user}" ]]; then
    echo "Unauthorized ownership found"
    exit 1
  fi
done

echo "No unauthorized ownership found"
exit 0

