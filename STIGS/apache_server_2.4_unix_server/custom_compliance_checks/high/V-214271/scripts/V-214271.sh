
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214271
# Severity: high

# Identify the account that is running the "httpd" process
httpd_account=$(ps -ef | grep -i httpd | grep -v grep | awk '{print $1}' | uniq)

# Check to see if the account has a valid login shell
login_shell=$(cut -d: -f1,7 /etc/passwd | grep -i $httpd_account)

# If the service account has a valid login shell, verify that no password is configured for the account
password=$(cut -d: -f1,2 /etc/shadow | grep -i $httpd_account)

if [[ $login_shell != *"/sbin/nologin"* ]] && [[ $password != *"!!"* ]]; then
    echo "STIG Finding ID: V-214271 - The account running the httpd process has a valid login shell and a password defined."
    exit 1
else
    exit 0
fi

