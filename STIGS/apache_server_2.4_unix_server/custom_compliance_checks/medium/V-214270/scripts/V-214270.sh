
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214270
# Severity: medium

# Get the installed version of Apache
installed_version=$(httpd -v | awk -F"[/.]" 'NR==1{print $4"."$5}')

# Get the latest version of Apache from the official website
latest_version=$(curl -s https://httpd.apache.org/ | grep -oP '(?<=The Apache HTTP Server Project is an effort to develop and maintain an open-source HTTP server for modern operating systems including UNIX and Windows. The goal of this project is to provide a secure, efficient and extensible server that provides HTTP services in sync with the current HTTP standards. <p>The latest version of Apache httpd is )[^<]*')

# Compare the installed version with the latest version
if [[ $(echo "$installed_version $latest_version" | awk '{print ($1 < $2)}') -eq 1 ]]; then
    echo "Apache version is outdated"
    exit 1
else
    echo "Apache version is up to date"
    exit 0
fi

