# V-214230 - The Apache web server must use cryptography to protect the integrity of remote sessions.

**Severity**: medium

**Description**:
Data exchanged between the user and the Apache web server can range from static display data to credentials used to log on to the hosted application. Even when data appears to be static, the non-displayed logic in a web page may expose business logic or trusted system relationships. The integrity of all the data being exchanged between the user and the Apache web server must always be trusted. To protect the integrity and trust, encryption methods should be used to protect the complete communication session.

Satisfies: SRG-APP-000014-WSR-000006, SRG-APP-000015-WSR-000014, SRG-APP-000033-WSR-000169, SRG-APP-000172-WSR-000104, SRG-APP-000179-WSR-000110, SRG-APP-000179-WSR-000111, SRG-APP-000224-WSR-000139, SRG-APP-000427-WSR-000186, SRG-APP-000439-WSR-000151, SRG-APP-000439-WSR-000152, SRG-APP-000439-WSR-000153, SRG-APP-000442-WSR-000182

**Fix Text**:```
# cat /etc/httpd/conf.d/ssl.conf | grep "SSLProtocol - ALL +TLSv1.2"

Ensure the "SSLProtocol" is added to the ssl.conf file and looks like the following:

SSLProtocol -ALL +TLSv1.2

Restart Apache: apachectl restart
```
**Check Text**:
Verify the "ssl module" module is loaded
# httpd -M | grep -i ssl_module
Output:  ssl_module (shared) 

If the "ssl_module" is not found, this is a finding. 

Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file:

# apachectl -V | egrep -i 'httpd_root|server_config_file'
-D HTTPD_ROOT="/etc/httpd"
-D SERVER_CONFIG_FILE="conf/httpd.conf"

Note: The apachectl front end is the preferred method for locating the Apache httpd file. For some Linux distributions, "apache2ctl -V" or  "httpd -V" can also be used.  

Search for the directive "SSLProtocol" in the "httpd.conf" file: 

# cat /<path_to_file>/httpd.conf | grep -i "SSLProtocol" 

If the "SSLProtocol" directive is missing or does not look like the following, this is a finding: 

SSLProtocol -ALL +TLSv1.2 

If the TLS version is not TLS 1.2 or higher, according to NIST SP 800-52 Rev 2, or if non-FIPS-approved algorithms are enabled, this is a finding.
