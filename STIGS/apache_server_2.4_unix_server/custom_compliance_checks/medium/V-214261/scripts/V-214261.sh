
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214261
# Severity: medium

# Check if Apache is installed
if ! command -v apache2 &> /dev/null
then
    echo "Apache is not installed. Exiting."
    exit 0
fi

# Get the Apache configuration file path
apache_config_file=$(apache2 -V | grep SERVER_CONFIG_FILE | cut -d'=' -f2 | tr -d '"')

# Check the permissions of the Apache configuration file
permissions=$(stat -c %a "$apache_config_file")

# Check the owner of the Apache configuration file
owner=$(stat -c %U "$apache_config_file")

# Check the group of the Apache configuration file
group=$(stat -c %G "$apache_config_file")

# If the owner is not root, or the group is not root, or the permissions are not 644, then exit with 1
if [[ "$owner" != "root" ]] || [[ "$group" != "root" ]] || [[ "$permissions" != "644" ]]
then
    echo "The Apache configuration file does not have the correct permissions or ownership. Exiting."
    exit 1
fi

# If everything is fine, then exit with 0
exit 0

