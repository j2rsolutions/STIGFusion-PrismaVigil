# V-214239 - The Apache web server must not perform user management for hosted applications.

**Severity**: medium

**Description**:
User management and authentication can be an essential part of any application hosted by the web server. Along with authenticating users, the user management function must perform several other tasks such as password complexity, locking users after a configurable number of failed logons, and management of temporary and emergency accounts. All of this must be done enterprise-wide.

The web server contains a minimal user management function, but the web server user management function does not offer enterprise-wide user management, and user management is not the primary function of the web server. User management for the hosted applications should be done through a facility that is built for enterprise-wide user management, such as LDAP and Active Directory.

**Fix Text**:
 Comment out the "AuthUserFile" lines found in the Apache configuration\.

**Check Text**:
Review the web server documentation and configuration to determine if the web server is being used as a user management application.
 
Search for "AuthUserFile" in the configuration files in the installed Apache Path.
 
Example:

grep -rin AuthUserFile *
 
If there are uncommented lines pointing to files on disk using the above configuration option, this is a finding.
