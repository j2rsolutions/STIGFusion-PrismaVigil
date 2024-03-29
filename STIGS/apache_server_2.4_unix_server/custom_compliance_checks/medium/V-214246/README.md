# V-214246 - The Apache web server must be configured to use a specified IP address and port.

**Severity**: medium

**Description**:
The web server must be configured to listen on a specified IP address and port. Without specifying an IP address and port for the web server to use, the web server will listen on all IP addresses available to the hosting server. If the web server has multiple IP addresses, i.e., a management IP address, the web server will also accept connections on the management IP address.

Accessing the hosted application through an IP address normally used for non-application functions opens the possibility of user access to resources, utilities, files, ports, and protocols that are protected on the desired application IP address.

Satisfies: SRG-APP-000142-WSR-000089, SRG-APP-000176-WSR-000096

**Fix Text**:
```Determine the location of the "HTTPD\_ROOT" directory and the "httpd\.conf" file:

\# apachectl \-V \| egrep \-i 'httpd\_root\|server\_config\_file'
\-D HTTPD\_ROOT="/etc/httpd"
\-D SERVER\_CONFIG\_FILE="conf/httpd\.conf"

Set the "Listen" directive to listen on a specific IP address and port\.

Restart Apache: apachectl restart```

**Check Text**:
```Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file:

# apachectl -V | egrep -i 'httpd_root|server_config_file'
-D HTTPD_ROOT="/etc/httpd"
-D SERVER_CONFIG_FILE="conf/httpd.conf"

Note: The apachectl front end is the preferred method for locating the Apache httpd file. For some Linux distributions, "apache2ctl -V" or  "httpd -V" can also be used. 
Search for the "Listen" directive:

# cat /<path_to_file>/httpd.conf | grep -i "Listen"

Verify that any enabled "Listen" directives specify both an IP address and port number.

If the "Listen" directive is found with only an IP address or only a port number specified, this is finding.

If the IP address is all zeros (i.e., 0.0.0.0:80 or [::ffff:0.0.0.0]:80), this is a finding.

If the "Listen" directive does not exist, this is a finding.```
