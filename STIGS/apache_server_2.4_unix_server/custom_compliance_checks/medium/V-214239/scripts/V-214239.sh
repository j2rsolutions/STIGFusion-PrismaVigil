
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214239
# Severity: medium

# Check if Apache is installed
if ! command -v apache2 &> /dev/null
then
    echo "Apache is not installed. Exiting with code 0."
    exit 0
fi

# Get Apache config directory
apache_config_dir=$(apache2ctl -V | grep SERVER_CONFIG_FILE | cut -d '"' -f 2 | xargs dirname)

# Search for "AuthUserFile" in the configuration files
auth_user_file_lines=$(grep -rin "AuthUserFile" $apache_config_dir)

if [[ -z "$auth_user_file_lines" ]]
then
    # No uncommented lines found pointing to files on disk using "AuthUserFile"
    exit 0
else
    # Uncommented lines found pointing to files on disk using "AuthUserFile"
    echo "Found uncommented AuthUserFile lines in Apache configuration files. Exiting with code 1."
    exit 1
fi

