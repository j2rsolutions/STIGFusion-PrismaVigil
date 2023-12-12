
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214241
# Severity: medium

# Check if any of the proxy modules are present
modules=$(httpd -M | sort)
for module in proxy_module proxy_ajp_module proxy_balancer_module proxy_ftp_module proxy_http_module proxy_connect_module
do
    if [[ $modules == *"$module"* ]]; then
        echo "Proxy module $module is present"
        exit 1
    fi
done

# Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file
httpd_root=$(apachectl -V | egrep -i 'httpd_root' | cut -d'"' -f2)
server_config_file=$(apachectl -V | egrep -i 'server_config_file' | cut -d'"' -f2)

# Check if ProxyRequest directive is set to “On”
if grep -q "ProxyRequest On" "$httpd_root/$server_config_file"; then
    echo "ProxyRequest directive is set to On"
    exit 1
fi

exit 0

