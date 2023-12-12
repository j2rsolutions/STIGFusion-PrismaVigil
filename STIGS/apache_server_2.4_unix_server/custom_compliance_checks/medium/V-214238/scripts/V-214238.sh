
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214238
# Severity: medium

# Check if httpd is installed
if ! command -v httpd &> /dev/null
then
    echo "httpd could not be found"
    exit 1
fi

# Get the list of loaded modules
modules=$(httpd -M | awk '{print $1}' | sort)

# List of basic modules that are needed for basic web function
basic_modules=("core_module" "http_module" "so_module" "mpm_prefork_module")

# Check each module
for module in $modules
do
    if [[ ! " ${basic_modules[@]} " =~ " ${module} " ]]; then
        echo "Unnecessary module found: $module"
        exit 1
    fi
done

# If no unnecessary modules found
echo "All modules are necessary for operation"
exit 0

