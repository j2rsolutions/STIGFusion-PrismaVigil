
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214126
# Severity: medium

# Check for any unapproved extensions
unapproved_extensions=$(sudo -u postgres psql -c "select * from pg_extension where extname != 'plpgsql'")

# If any unapproved extensions exist, exit with 1
if [[ $unapproved_extensions ]]; then
    echo "Unapproved extensions found: $unapproved_extensions"
    exit 1
else
    echo "No unapproved extensions found."
    exit 0
fi

