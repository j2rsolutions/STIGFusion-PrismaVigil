# V-214253 - The Apache web server must generate a session ID using as much of the character set as possible to reduce the risk of brute force.

**Severity**: high

**Description**:
Generating a session identifier (ID) that is not easily guessed through brute force is essential to deter several types of session attacks. By knowing the session ID, an attacker can hijack a user session that has already been user-authenticated by the hosted application. The attacker does not need to guess user identifiers and passwords or have a secure token since the user session has already been authenticated.

By generating session IDs that contain as much of the character set as possible, i.e., A-Z, a-z, and 0-9, the session ID becomes exponentially harder to guess.

Satisfies: SRG-APP-000223-WSR-000145, SRG-APP-000224-WSR-000135, SRG-APP-000224-WSR-000136, SRG-APP-000224-WSR-000138

**Fix Text**:```
Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file:

# apachectl -V | egrep -i 'httpd_root|server_config_file'
-D HTTPD_ROOT="/etc/httpd"
-D SERVER_CONFIG_FILE="conf/httpd.conf"

Load the "unique_id_module". 

Example: LoadModule unique_id_module modules/mod_unique_id.so

Restart Apache: apachectl restart
```
**Check Text**:
Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file:

# apachectl -V | egrep -i 'httpd_root|server_config_file'
-D HTTPD_ROOT="/etc/httpd"
-D SERVER_CONFIG_FILE="conf/httpd.conf"

Note: The apachectl front end is the preferred method for locating the Apache httpd file. For some Linux distributions, "apache2ctl -V" or  "httpd -V" can also be used. 

Verify the "unique_id_module" is loaded:

run httpd -M | grep unique_id 
If no unique_id is returned, this is a finding.
