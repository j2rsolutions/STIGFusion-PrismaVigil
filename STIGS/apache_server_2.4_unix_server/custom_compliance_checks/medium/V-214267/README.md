# V-214267 - The Apache web server must be protected from being stopped by a non-privileged user.

**Severity**: medium

**Description**:
An attacker has at least two reasons to stop a web server. The first is to cause a denial of service (DoS), and the second is to put in place changes the attacker made to the web server configuration.

To prohibit an attacker from stopping the Apache web server, the process ID (pid) of the web server and the utilities used to start/stop it must be protected from access by non-privileged users. By knowing the "pid" and having access to the Apache web server utilities, a non-privileged user has a greater capability of stopping the server, whether intentionally or unintentionally.

**Fix Text**:```
Review the web server documentation and deployed configuration to determine where the process ID is stored and which utilities are used to start/stop the web server.

Determine where the "httpd.pid" file is located by running the following command:

find / -name "httpd.pid"

Run the following commands:
 
# cd <'httpd.pid location'>/
# chown <'service account'> httpd.pid 
# chmod 644 httpd.pid 
# cd /usr/sbin 
# chown <'service account'> service apachectl 
# chmod 755 service apachectl
```
**Check Text**:
Review the web server documentation and deployed configuration to determine where the process ID is stored and which utilities are used to start/stop the web server.

Locate the httpd.pid file and list its permission set and owner/group

# find / -name “httpd.pid
Output should be similar to: /run/httpd/httpd.pid 

# ls -laH /run/httpd/httpd.pid
Output should be similar -rw-r--r--. 1 root root 5 Jun 13 03:18 /run/httpd/httpd.pid

If the file owner/group is not an administrative service account, this is a finding.

If permission set is not 644 or more restrictive, this is a finding.
 
Verify the Apache service utilities (binaries) have the correct permission set and are user/group owned by an administrator account

# ls -laH /usr/sbin/service
Output should be similar: -rwxr-xr-x. 1 root root 3.2K Aug 19, 2019 /usr/sbin/service

# ls -laH /usr/sbin/apachectl
Output should be similar: -rwxr-xr-x. 1 root root 4.2K Oct 8, 2019 /usr/sbin/apachectl
 
If the service utilities owner/group is not an administrative service account, this is a finding.
 
If permission set is not 755 or more restrictive, this is a finding.
