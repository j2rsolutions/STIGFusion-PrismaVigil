# V-214232 - The Apache web server must generate, at a minimum, log records for system startup and shutdown, system access, and system authentication events.

**Severity**: medium

**Description**:
Log records can be generated from various components within the Apache web server (e.g., httpd, plug-ins to external backends, etc.). From a web server perspective, certain specific Apache web server functionalities may be logged as well. The Apache web server must allow the definition of what events are to be logged. As conditions change, the number and types of events to be logged may change, and the Apache web server must be able to facilitate these changes.

The minimum list of logged events should be those pertaining to system startup and shutdown, system access, and system authentication events. If these events are not logged at a minimum, any type of forensic investigation would be missing pertinent information needed to replay what occurred.


Satisfies: SRG-APP-000089-WSR-000047, SRG-APP-000092-WSR-000055, SRG-APP-000095-WSR-000056, SRG-APP-000096-WSR-000057, SRG-APP-000097-WSR-000058, SRG-APP-000098-WSR-000059, SRG-APP-000099-WSR-000061, SRG-APP-000100-WSR-000064

**Fix Text**:
```Determine the location of the "HTTPD\_ROOT" directory and the "httpd\.conf" file:

\# apachectl \-V \| egrep \-i 'httpd\_root\|server\_config\_file'
\-D HTTPD\_ROOT="/etc/httpd"
\-D SERVER\_CONFIG\_FILE="conf/httpd\.conf"

Uncomment the "log\_config\_module" module line\.

Configure the "LogFormat" in the "httpd\.conf" file to look like the following:

LogFormat "%a %A %h %H %l %m %s %t %u %U \\"%\{Referer\}i\\" " common

Restart Apache: apachectl restart

Note: The log format could be using different variables based on the environment; however it should be verified to ensure it is producing the same end result of logged elements\.  

The logging elements required breakdown as follows:
%a       remote IP address
%A       local IP address
%h       IP address of requesting client
%H      the request protocol
%l        user ID of the requesting client
%m      request method
%s        status
%t        time the request was received
%u       user ID of the remote user
%U       URL path requested```

**Check Text**:
```Verify the Log Configuration Module is loaded:
# httpd -M | grep -i log_config_module
Output:  log_config_module (shared)

If the "log_config_module" is not enabled, this is a finding.

Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file:

# apachectl -V | egrep -i 'httpd_root|server_config_file'
-D HTTPD_ROOT="/etc/httpd"
-D SERVER_CONFIG_FILE="conf/httpd.conf"

Note: The apachectl front end is the preferred method for locating the Apache httpd file. For some Linux distributions, "apache2ctl -V" or  "httpd -V" can also be used.  

Search for the directive "LogFormat" in the "httpd.conf" file:

# cat /<path_to_file>/httpd.conf | grep -i "LogFormat"

If the "LogFormat" directive is missing, this is a finding:

An example is:
LogFormat "%a %A %h %H %l %m %s %t %u %U \"%{Referer}i\" " common```
