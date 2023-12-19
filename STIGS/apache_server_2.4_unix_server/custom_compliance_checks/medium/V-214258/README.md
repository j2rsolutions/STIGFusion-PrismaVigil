# V-214258 - The Apache web server must set an inactive timeout for sessions.

**Severity**: medium

**Description**:
Leaving sessions open indefinitely is a major security risk. An attacker can easily use an already authenticated session to access the hosted application as the previously authenticated user. By closing sessions after a set period of inactivity, the Apache web server can make certain that those sessions that are not closed through the user logging out of an application are eventually closed. mod_reqtimeout is an Apache module designed to shut down connections from clients taking too long to send their request, as seen in many attacks. This module provides a directive that allows Apache to close the connection if it senses that the client is not sending data quickly enough.

Acceptable values are 5 minutes for high-value applications, 10 minutes for medium-value applications, and 20 minutes for low-value applications.

**Fix Text**:
```Determine the location of the "HTTPD\_ROOT" directory and the "httpd\.conf" file:

\# apachectl \-V \| egrep \-i 'httpd\_root\|server\_config\_file'
\-D HTTPD\_ROOT="/etc/httpd"
\-D SERVER\_CONFIG\_FILE="conf/httpd\.conf"

Load the "reqtimeout\_module"\.

Set the "RequestReadTimeout" directive to specific values applicable to the website\.```

**Check Text**:
```Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file:

# apachectl -V | egrep -i 'httpd_root|server_config_file'
-D HTTPD_ROOT="/etc/httpd"
-D SERVER_CONFIG_FILE="conf/httpd.conf"

Note: The apachectl front end is the preferred method for locating the Apache httpd file. For some Linux distributions, "apache2ctl -V" or  "httpd -V" can also be used. 

Verify the "reqtimeout_module" is loaded:

Change to the root directory of Apache and run the following command to verify the "reqtimeout_module" is loaded:

# httpd -M | grep reqtimeout_module
Outout: reqtimeout_module (shared)

If the "reqtimeout_module" is not loaded, this is a finding.

Verify the "RequestReadTimeout" directive is configured. 
Example: RequestReadTimeout handshake=5 header=10 body=30
Allows for 5 seconds to complete the TLS handshake, 10 seconds to receive the request headers, and 30 seconds for receiving the request body.
The values will depend upon the website. 
The intent of this requirement is to ensure the RequestReadTimeout is explicitly configured.
If the "reqtimeout_module" is loaded and the "RequestReadTimeout" directive is not configured, this is a finding.```
