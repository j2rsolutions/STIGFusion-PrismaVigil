
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214273
# Severity: high

# Check Apache version
apache_version=$(httpd -v | grep "Server version" | awk -F'/' '{print $2}' | awk '{print $1}')

# Compare with minimum required version
min_version="2.4"

if [[ $(echo -e "$apache_version\n$min_version" | sort -V | head -n1) = $min_version ]]; then
    echo "Apache version is compliant"
    exit 0
else
    echo "Apache version is not compliant"
    exit 1
fi

