# V-214256 - Warning and error messages displayed to clients must be modified to minimize the identity of the Apache web server, patches, loaded modules, and directory paths.

**Severity**: medium

**Description**:
Information needed by an attacker to begin looking for possible vulnerabilities in a web server includes any information about the web server, backend systems being accessed, and plug-ins or modules being used.

Web servers will often display error messages to client users, displaying enough information to aid in the debugging of the error. The information given back in error messages may display the web server type, version, patches installed, plug-ins and modules installed, type of code being used by the hosted application, and any backends being used for data storage.

This information could be used by an attacker to blueprint what type of attacks might be successful. The information given to users must be minimized to not aid in the blueprinting of the Apache web server.

**Fix Text**:
 Determine the location of the "HTTPD\_ROOT" directory and the "httpd\.conf" file:

\# apachectl \-V \| egrep \-i 'httpd\_root\|server\_config\_file'
\-D HTTPD\_ROOT="/etc/httpd"
\-D SERVER\_CONFIG\_FILE="conf/httpd\.conf"

Use the "ErrorDocument" directive to enable custom error pages for 4xx or 5xx HTTP status codes\.

ErrorDocument 500 "Sorry, our script crashed\. Oh dear"
ErrorDocument 500 /cgi\-bin/crash\-recover
ErrorDocument 500 http://error\.example\.com/server\_error\.html
ErrorDocument 404 /errors/not\_found\.html
ErrorDocument 401 /subscription/how\_to\_subscribe\.html

The syntax of the ErrorDocument directive is:

ErrorDocument <3\-digit\-code> <action>

Additional information: 

https://httpd\.apache\.org/docs/2\.4/custom\-error\.html

**Check Text**:
Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file:

# apachectl -V | egrep -i 'httpd_root|server_config_file'
-D HTTPD_ROOT="/etc/httpd"
-D SERVER_CONFIG_FILE="conf/httpd.conf"

Note: The apachectl front end is the preferred method for locating the Apache httpd file. For some Linux distributions, "apache2ctl -V" or  "httpd -V" can also be used. 

If the "ErrorDocument" directive is not being used for custom error pages for "4xx" or "5xx" HTTP status codes, this is a finding.

# cat /<path_to_file>/httpd.conf | grep -i "ErrorDocument"
