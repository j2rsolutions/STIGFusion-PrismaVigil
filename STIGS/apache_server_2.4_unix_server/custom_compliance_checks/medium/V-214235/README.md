# V-214235 - The Apache web server log files must only be accessible by privileged users.

**Severity**: medium

**Description**:
Log data is essential in the investigation of events. If log data were to become compromised, competent forensic analysis and discovery of the true source of potentially malicious system activity would be difficult, if not impossible, to achieve. In addition, access to log records provides information an attacker could potentially use to their advantage since each event record might contain communication ports, protocols, services, trust relationships, user names, etc.

The web server must protect the log data from unauthorized read, write, copy, etc. This can be done by the web server if the web server is also doing the logging function. The web server may also use an external log system. In either case, the logs must be protected from access by non-privileged users.

**Fix Text**:
To protect the integrity of the data that is being captured in the log files, ensure that only the members of the Auditors group, Administrators, and the user assigned to run the web server software is granted permissions to read the log files.

**Check Text**:```
Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file:

# apachectl -V | egrep -i 'httpd_root|server_config_file'
-D HTTPD_ROOT="/etc/httpd"
-D SERVER_CONFIG_FILE="conf/httpd.conf"

Note: The apachectl front end is the preferred method for locating the Apache httpd file. For some Linux distributions, "apache2ctl -V" or  "httpd -V" can also be used.

Work with the Administrator to locate the log files:
Example: /etc/httpd/logs

List the POSIX permission set and owner/group of the log files:
# ls -laH /etc/httpd/logs/*log*
Output Example:
-rw-r------. 1 apache root    0 Sep 27 2020 /etc/httpd/logs/access_log
-rw-r------. 1 apache root 1235 Sep 23 2020 /etc/httpd/logs/access_log-20200927
-rw-r------. 1 apache root  332 Sep 26 03:40 /etc/httpd/logs/error_log

Only system administrators and service accounts running the server should have permissions to the files and the POSIX permissions should be set to 640 or more restrictive

If any users other than those authorized have read access to the log files, this is a finding.

```