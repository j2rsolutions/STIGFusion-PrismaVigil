# V-214259 - The Apache web server must restrict inbound connections from nonsecure zones.

**Severity**: medium

**Description**:
Remote access to the Apache web server is any access that communicates through an external, non-organization-controlled network. Remote access can be used to access hosted applications or to perform management functions.

A web server can be accessed remotely and must be capable of restricting access from what the DoD defines as nonsecure zones. Nonsecure zones are defined as any IP, subnet, or region that is defined as a threat to the organization. The nonsecure zones must be defined for public web servers logically located in a DMZ, as well as private web servers with perimeter protection devices. By restricting access from nonsecure zones, through the internal web server access list, the Apache web server can stop or slow denial-of-service (DoS) attacks on the web server.

**Fix Text**:
Configure the "http.conf" file to include restrictions.

Example:

<RequireAll>
Require not ip 192.168.205
Require not host phishers.example.com
</RequireAll>

**Check Text**:
If external controls such as host-based firewalls are used to restrict this access, this check is Not Applicable.

Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file:

# apachectl -V | egrep -i 'httpd_root|server_config_file'
-D HTTPD_ROOT="/etc/httpd"
-D SERVER_CONFIG_FILE="conf/httpd.conf"

Note: The apachectl front end is the preferred method for locating the Apache httpd file. For some Linux distributions, "apache2ctl -V" or  "httpd -V" can also be used. 

Search for the "RequireAll" directive:

# cat /<path_to_file>/httpd.conf | grep -i "RequireAll"

If "RequireAll" is not configured, or IP ranges configured to allow are not restrictive enough to prevent connections from nonsecure zones, this is a finding.
