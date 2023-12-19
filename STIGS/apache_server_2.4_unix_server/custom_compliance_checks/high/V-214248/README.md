# V-214248 - Apache web server application directories,  libraries, and configuration files must only be accessible to privileged users.

**Severity**: high

**Description**:
By separating Apache web server security functions from non-privileged users, roles can be developed that can then be used to administer the Apache web server. Forcing users to change from a non-privileged account to a privileged account when operating on the Apache web server or on security-relevant information forces users to only operate as a Web Server Administrator when necessary. Operating in this manner allows for better logging of changes and better forensic information and limits accidental changes to the Apache web server.

To limit changes to the Apache web server and limit exposure to any adverse effects from the changes, files such as the Apache web server application files, libraries, and configuration files must have permissions and ownership set properly to only allow privileged users access.

**Fix Text**:
 Ensure non\-administrators are not allowed access to the directory tree, the shell, or other operating system functions and utilities\.

**Check Text**:
Obtain a list of the user accounts for the system, noting the privileges for each account.

Verify with the SA or the Information System Security Officer (ISSO) that all privileged accounts are mission essential and documented.

Verify with the SA or the ISSO that all non-administrator access to shell scripts and operating system functions are mission essential and documented.

If undocumented privileged accounts are present, this is a finding.

If undocumented access to shell scripts or operating system functions is present, this is a finding.
