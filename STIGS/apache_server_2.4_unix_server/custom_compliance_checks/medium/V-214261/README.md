# V-214261 - Non-privileged accounts on the hosting system must only access Apache web server security-relevant information and functions through a distinct administrative account.

**Severity**: medium

**Description**:
By separating Apache web server security functions from non-privileged users, roles can be developed that can then be used to administer the Apache web server. Forcing users to change from a non-privileged account to a privileged account when operating on the Apache web server or on security-relevant information forces users to only operate as a Web Server Administrator when necessary. Operating in this manner allows for better logging of changes and better forensic information and limits accidental changes to the Apache web server.

**Fix Text**:
Restrict access to the web administration tool to only the System Administrator, Web Manager, or the Web Manager designees.

**Check Text**:```
Determine which tool or control file is used to control the configuration of the web server.

If the control of the web server is done via control files, verify who has update access to them. If tools are being used to configure the web server, determine who has access to execute the tools.

If accounts other than the System Administrator (SA), the Web Manager, or the Web Manager designees have access to the web administration tool or control files, this is a finding.
```