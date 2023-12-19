# V-214243 - The Apache web server must have resource mappings set to disable the serving of certain file types.

**Severity**: medium

**Description**:
Resource mapping is the process of tying a particular file type to a process in the web server that can serve that type of file to a requesting client and to identify which file types are not to be delivered to a client.

By not specifying which files can and cannot be served to a user, the web server could deliver to a user web server configuration files, log files, password files, etc.

The web server must only allow hosted application file types to be served to a user, and all other types must be disabled.

Satisfies: SRG-APP-000141-WSR-000081, SRG-APP-000141-WSR-000083

**Fix Text**:```
Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file:

# apachectl -V | egrep -i 'httpd_root|server_config_file'
-D HTTPD_ROOT="/etc/httpd"
-D SERVER_CONFIG_FILE="conf/httpd.conf"

Disable MIME types for .exe, .dll, .com, .bat, and .csh programs.

If "Action" or "AddHandler" exist within the "httpd.conf" file and they configure .exe, .dll, .com, .bat, or .csh, remove those references.

Restart Apache: apachectl restart

Ensure this process is documented and approved by the ISSO.
```
**Check Text**:
Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file:

# apachectl -V | egrep -i 'httpd_root|server_config_file'
-D HTTPD_ROOT="/etc/httpd"
-D SERVER_CONFIG_FILE="conf/httpd.conf"

Note: The apachectl front end is the preferred method for locating the Apache httpd file. For some Linux distributions, "apache2ctl -V" or  "httpd -V" can also be used.

Review any "Action" or "AddHandler" directives:

# cat /<path_to_file>/httpd.conf | grep -i "Action"
# cat /<path_to_file>/httpd.conf | grep -i "AddHandler"

If "Action" or "AddHandler" exist and they configure .exe, .dll, .com, .bat, or .csh, or any other shell as a viewer for documents, this is a finding.

If this is not documented and approved by the Information System Security Officer (ISSO), this is a finding.
