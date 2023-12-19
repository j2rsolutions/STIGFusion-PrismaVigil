# V-214228 - The Apache web server must limit the number of allowed simultaneous session requests.

**Severity**: medium

**Description**:
Apache web server management includes the ability to control the number of users and user sessions that utilize an Apache web server. Limiting the number of allowed users and sessions per user is helpful in limiting risks related to several types of denial-of-service (DOS) attacks.

Although there is some latitude concerning the settings, they should follow DoD-recommended values and be configurable to allow for future DoD direction. While the DoD will specify recommended values, the values can be adjusted to accommodate the operational requirements of a given system.

**Fix Text**:
Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file:

# apachectl -V | egrep -i 'httpd_root|server_config_file'
-D HTTPD_ROOT="/etc/httpd"
-D SERVER_CONFIG_FILE="conf/httpd.conf"

Note: The apachectl front end is the preferred method for locating the Apache httpd file. For some Linux distributions, "apache2ctl -V" or  "httpd -V" can also be used.  

Set the "KeepAlive" directive to a value of "on"; add the directive if it does not exist.

Set the "MaxKeepAliveRequests" directive to a value of "100" or greater; add the directive if it does not exist.

Restart Apache: apachectl restart

**Check Text**:```
Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file:

# apachectl -V | egrep -i 'httpd_root|server_config_file'
-D HTTPD_ROOT="/etc/httpd"
-D SERVER_CONFIG_FILE="conf/httpd.conf"

Note: The apachectl front end is the preferred method for locating the Apache httpd file. For some Linux distributions, "apache2ctl -V" or  "httpd -V" can also be used.

Search for the directives "KeepAlive" and "MaxKeepAliveRequests" in the "httpd.conf" file:

# cat /<path_to_file>/httpd.conf | grep -i "keepalive"

KeepAlive On
MaxKeepAliveRequests 100

If the value of "KeepAlive" is set to "off" or does not exist, this is a finding.

If the value of "MaxKeepAliveRequests" is set to a value less than "100" or does not exist, this is a finding.
```