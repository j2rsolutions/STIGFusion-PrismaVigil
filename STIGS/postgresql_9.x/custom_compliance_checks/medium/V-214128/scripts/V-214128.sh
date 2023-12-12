
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214128
# Severity: medium

# Check for installed postgres packages on RHEL/CENT Systems
if [ -f /etc/redhat-release ]; then
    installed_packages=$(yum list installed | grep postgres)
    if [ -n "$installed_packages" ]; then
        echo "Unnecessary postgres packages installed: $installed_packages"
        exit 1
    fi
fi

# Check for installed postgres packages on Debian Systems
if [ -f /etc/debian_version ]; then
    installed_packages=$(dpkg --get-selections | grep postgres)
    if [ -n "$installed_packages" ]; then
        echo "Unnecessary postgres packages installed: $installed_packages"
        exit 1
    fi
fi

# If no unnecessary packages found, exit with 0
exit 0

