# V-214255 - The Apache web server must be tuned to handle the operational requirements of the hosted application.

**Severity**: medium

**Description**:
A denial of service (DoS) can occur when the Apache web server is so overwhelmed that it can no longer respond to additional requests. A web server not properly tuned may become overwhelmed and cause a DoS condition even with expected traffic from users. To avoid a DoS, the Apache web server must be tuned to handle the expected traffic for the hosted applications.

Satisfies: SRG-APP-000246-WSR-000149, SRG-APP-000435-WSR-000148

**Fix Text**:
Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file:

# apachectl -V | egrep -i 'httpd_root|server_config_file'
-D HTTPD_ROOT="/etc/httpd"
-D SERVER_CONFIG_FILE="conf/httpd.conf"

Add or modify the "Timeout" directive to have a value of "10" seconds or less:

"Timeout 10"

**Check Text**:
Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file:

# apachectl -V | egrep -i 'httpd_root|server_config_file'
-D HTTPD_ROOT="/etc/httpd"
-D SERVER_CONFIG_FILE="conf/httpd.conf"

Note: The apachectl front end is the preferred method for locating the Apache httpd file. For some Linux distributions, "apache2ctl -V" or  "httpd -V" can also be used. 

Verify that the "Timeout" directive is specified to have a value of "10" seconds or less.

# cat /<path_to_file>/httpd.conf | grep -i "Timeout"

If the "Timeout" directive is not configured or is set for more than "10" seconds, this is a finding.
