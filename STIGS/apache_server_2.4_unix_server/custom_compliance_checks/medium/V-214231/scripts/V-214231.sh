
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214231
# Severity: medium

# Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file
httpd_root=$(apachectl -V | egrep -i 'httpd_root' | cut -d'"' -f2)
server_config_file=$(apachectl -V | egrep -i 'server_config_file' | cut -d'"' -f2)

# Full path to httpd.conf
httpd_conf="${httpd_root}/${server_config_file}"

# Check if "CustomLog" directive exists in the "httpd.conf" file
if grep -iq "CustomLog" "$httpd_conf"; then
    echo 'CustomLog directive exists'
    exit 0
else
    echo 'CustomLog directive missing'
    exit 1
fi

