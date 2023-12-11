
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214247
# Severity: medium

# Get the apache user
apache_user=$(ps aux | grep '[a]pache' | awk '{print $1}' | uniq)

# Check if there are any files or directories owned by the apache user
owned_files=$(find / -user $apache_user 2>/dev/null)

if [[ -z "$owned_files" ]]; then
    echo "No files or directories owned by Apache user"
    exit 0
else
    echo "Files or directories owned by Apache user found"
    exit 1
fi

