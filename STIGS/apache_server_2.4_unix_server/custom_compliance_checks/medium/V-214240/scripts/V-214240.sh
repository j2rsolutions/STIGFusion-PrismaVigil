
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214240
# Severity: medium

# This script checks for unnecessary software installed on the server.
# It should be run by the ISSO to verify compliance with the STIG.

# List of allowed software
allowed_software=("apache2" "mysql" "php" "ssh" "bash" "coreutils" "grep" "sed" "awk")

# Get list of installed software
installed_software=$(dpkg --get-selections | awk '{print $1}')

# Check each installed software
for software in $installed_software; do
    if ! [[ " ${allowed_software[@]} " =~ " ${software} " ]]; then
        echo "Unnecessary software installed: $software"
        exit 1
    fi
done

# If we made it here, no unnecessary software was found
exit 0

