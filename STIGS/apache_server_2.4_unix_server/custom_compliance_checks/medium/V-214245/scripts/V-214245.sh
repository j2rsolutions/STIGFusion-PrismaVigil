
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214245
# Severity: medium

# Check if Apache is installed
if ! command -v httpd &> /dev/null
then
    echo "Apache is not installed, exiting with 0"
    exit 0
fi

# Check for the presence of the modules
modules=("dav_module" "dav_fs_module" "dav_lock_module")
for module in "${modules[@]}"
do
    if httpd -M | sort | grep -q "$module"
    then
        echo "Found forbidden module: $module"
        exit 1
    fi
done

# If none of the forbidden modules are found, exit with 0
exit 0

