
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214067
# Severity: medium

# Check for unauthorized ownership of database objects
sudo su - postgres -c "psql -c '\dn *.*'" | grep -q unauthorized_user && echo 'Unauthorized user owns a schema' && exit 1
sudo su - postgres -c "psql -c '\dt *.*'" | grep -q unauthorized_user && echo 'Unauthorized user owns a table' && exit 1
sudo su - postgres -c "psql -c '\ds *.*'" | grep -q unauthorized_user && echo 'Unauthorized user owns a sequence' && exit 1
sudo su - postgres -c "psql -c '\dv *.*'" | grep -q unauthorized_user && echo 'Unauthorized user owns a view' && exit 1
sudo su - postgres -c "psql -c '\df+ *.*'" | grep -q unauthorized_user && echo 'Unauthorized user owns a function' && exit 1

# Check for unauthorized privileges
sudo su - postgres -c "psql -c '\dp *.*'" | grep -q unauthorized_role && echo 'Unauthorized role has privileges' && exit 1

# If no unauthorized ownership or privileges were found, exit with 0
exit 0

