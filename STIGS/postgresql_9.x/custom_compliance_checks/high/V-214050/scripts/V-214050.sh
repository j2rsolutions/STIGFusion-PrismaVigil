
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214050
# Severity: high

# Check the installed version of PostgreSQL
installed_version=$(sudo -u postgres psql --version | awk '{print $3}')

# Check the latest version of PostgreSQL from the official website
latest_version=$(curl -s http://www.postgresql.org/support/versioning/ | grep -oP 'The current version is \K[^<]+')

# Compare the installed version with the latest version
if [[ "$installed_version" != "$latest_version" ]]; then
    echo "PostgreSQL is not at the latest version. Current version: $installed_version, Latest version: $latest_version"
    exit 1
else
    echo "PostgreSQL is at the latest version: $installed_version"
    exit 0
fi

