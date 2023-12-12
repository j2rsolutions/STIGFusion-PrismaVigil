
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214229
# Severity: medium

# Check if the required modules are enabled
modules=$(httpd -M | grep -E 'session_module|usertrack')

if [[ $modules == *"usertrack_module (shared)"* ]] && [[ $modules == *"session_module (shared)"* ]]; then
    exit 0
else
    # If the modules are not enabled, check the httpd.conf file
    httpd_root=$(apachectl -V | grep -i 'httpd_root' | cut -d'"' -f2)
    server_config_file=$(apachectl -V | grep -i 'server_config_file' | cut -d'"' -f2)
    httpd_conf="${httpd_root}/${server_config_file}"

    session_module=$(cat $httpd_conf | grep -i "session_module")
    usertrack_module=$(cat $httpd_conf | grep -i "usertrack_module")

    if [[ -z $session_module ]] || [[ -z $usertrack_module ]]; then
        # If the directives are not present in the httpd.conf file, exit with 1
        exit 1
    else
        exit 0
    fi
fi

