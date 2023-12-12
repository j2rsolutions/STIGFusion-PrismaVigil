
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214274
# Severity: medium

htpasswd_file=$(find / -name htpasswd 2>/dev/null)

if [ -z "$htpasswd_file" ]; then
    echo "htpasswd file not found"
    exit 1
fi

permissions=$(stat -c %a "$htpasswd_file")

if [ "$permissions" -gt 550 ]; then
    echo "Permissions on htpasswd are greater than 550"
    exit 1
fi

owner=$(stat -c %U "$htpasswd_file")

if [ "$owner" != "root" ] && [ "$owner" != "webmanager" ]; then
    echo "Owner of htpasswd is not SA or Web Manager account"
    exit 1
fi

exit 0

