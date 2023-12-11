
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214230
# Severity: medium

# Check if ssl_module is loaded
ssl_module_check=$(httpd -M | grep -i ssl_module)
if [[ -z "$ssl_module_check" ]]; then
  echo "ssl_module not found"
  exit 1
fi

# Determine the location of the HTTPD_ROOT directory and the httpd.conf file
httpd_root=$(apachectl -V | egrep -i 'httpd_root' | cut -d'"' -f2)
server_config_file=$(apachectl -V | egrep -i 'server_config_file' | cut -d'"' -f2)

# Check if SSLProtocol directive is present and correctly configured
ssl_protocol_check=$(cat $httpd_root/$server_config_file | grep -i "SSLProtocol")
if [[ -z "$ssl_protocol_check" ]] || [[ "$ssl_protocol_check" != "SSLProtocol -ALL +TLSv1.2" ]]; then
  echo "SSLProtocol directive is missing or not correctly configured"
  exit 1
fi

# If all checks pass, exit with 0
exit 0

