
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214122
# Severity: medium

# Check if postgresql is installed
if ! command -v psql &> /dev/null
then
    echo "postgresql is not installed"
    exit 1
fi

# Check for non-administrative roles with administrative privileges
sudo su - postgres -c "psql -c '\du'" | awk 'NR>3 {print $1, $2}' | while read -r role attributes; do
    if [[ $attributes == *"Superuser"* ]] || [[ $attributes == *"Create role"* ]] || [[ $attributes == *"Create DB"* ]] || [[ $attributes == *"Bypass RLS"* ]]; then
        echo "Non-administrative role with administrative privileges found: $role"
        exit 1
    fi
done

# If no non-administrative roles with administrative privileges are found, exit with 0
exit 0

