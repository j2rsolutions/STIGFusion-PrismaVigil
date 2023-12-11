#!/bin/bash

# Prompt for console hostname
read -p "Enter console hostname: " console

# Prompt for API version
read -p "Enter API version (e.g., 31.02): " version

# Prompt for username
read -p "Enter username: " username

# Prompt for password (input will be hidden)
read -sp "Enter password: " password
echo

# File containing the custom compliance rules
custom_rules_file="custom_check.json"

# Check if custom rules file exists
if [ ! -f "$custom_rules_file" ]; then
    echo "Custom rules file not found: $custom_rules_file"
    exit 1
fi

# Perform the API request
curl -k -u "$username:$password" \
     -H "Content-Type: application/json" \
     -X PUT \
     -d "@$custom_rules_file" \
     "https://$console/api/v$version/custom-compliance"
