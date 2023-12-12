
#!/bin/bash

# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214269
# Severity: medium

httpd_conf_location=$(httpd -V | grep -i SERVER_CONFIG_FILE | cut -d '"' -f2)
ssl_conf_location="/etc/httpd/conf.d/ssl.conf"

httpd_conf_cipher=$(cat $httpd_conf_location | grep -i SSLCipherSuite)
ssl_conf_cipher=$(cat $ssl_conf_location | grep -i SSLCipherSuite)

if [[ $httpd_conf_cipher != *'!EXPORT'* ]] || [[ $httpd_conf_cipher != *'!EXP'* ]] || [[ -z $httpd_conf_cipher ]]; then
    echo "Finding ID: V-214269. The SSLCipherSuite directive in httpd.conf does not contain !EXPORT or !EXP or there are no enabled SSLCipherSuite directives."
    exit 1
fi

if [[ $ssl_conf_cipher != *'!EXPORT'* ]] || [[ $ssl_conf_cipher != *'!EXP'* ]] || [[ -z $ssl_conf_cipher ]]; then
    echo "Finding ID: V-214269. The SSLCipherSuite directive in ssl.conf does not contain !EXPORT or !EXP or there are no enabled SSLCipherSuite directives."
    exit 1
fi

exit 0

