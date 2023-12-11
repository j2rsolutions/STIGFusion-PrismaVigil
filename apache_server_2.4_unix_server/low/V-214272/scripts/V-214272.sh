
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214272
# Severity: low

# This script checks if the Apache server is using well-known ports (80 and 443) or those ports and services as registered and approved for use by the DoD Ports, Protocols, and Services Management (PPSM).

APACHE_CONFIG='/etc/httpd/conf/httpd.conf'

if grep -P '^Listen 80$|^Listen 443$' $APACHE_CONFIG > /dev/null
then
    echo "Apache server is using well-known ports (80 and 443)"
    exit 0
else
    echo "Apache server is not using well-known ports (80 and 443). Please ensure any variation in PPS is documented, registered, and approved by the PPSM."
    exit 1
fi

