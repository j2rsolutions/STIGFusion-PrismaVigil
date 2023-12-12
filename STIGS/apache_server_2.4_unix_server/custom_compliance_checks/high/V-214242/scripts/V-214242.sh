
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214242
# Severity: high

# Check for default index.html or welcome page
if grep -r -E 'DirectoryIndex index.html|DirectoryIndex welcome.html' /etc/apache2/; then
  echo 'Default index.html or welcome page is present'
  exit 1
fi

# Check for Apache User Manual content
if grep -r 'Alias /manual' /etc/apache2/; then
  echo 'Apache User Manual content is installed'
  exit 1
fi

# Check for Server Status handler
if grep -r 'Location /server-status' /etc/apache2/; then
  echo 'Server Status handler is configured'
  exit 1
fi

# Check for Server Information handler
if grep -r 'Location /server-info' /etc/apache2/; then
  echo 'Server Information handler is configured'
  exit 1
fi

# Check for other handler configurations
if grep -r 'perl-status' /etc/apache2/; then
  echo 'Other handler configurations are enabled'
  exit 1
fi

# If none of the checks failed, exit with 0
exit 0

