# V-235177 - The MySQL Database Server 8.0 must prohibit the use of cached authenticators after an organization-defined time period.

**Severity**: medium

**Description**:
If cached authentication information is out-of-date, the validity of the authentication information may be questionable.

**Fix Text**:
```Modify system settings to implement the organization\-defined limit on the lifetime of cached authenticators\.

Configure the MySQL server for GSSAPI/Kerberos LDAP authentication plugin to use the GSSAPI/Kerberos authentication method\.

Following is an example of plugin\-related settings the server my\.cnf file might contain:
\[mysqld\]
plugin\-load\-add=authentication\_ldap\_sasl\.so
authentication\_ldap\_sasl\_auth\_method\_name="GSSAPI"
authentication\_ldap\_sasl\_server\_host=198\.51\.100\.10
authentication\_ldap\_sasl\_server\_port=389
authentication\_ldap\_sasl\_bind\_root\_dn="cn=admin,cn=users,dc=MYSQL,dc=LOCAL"
authentication\_ldap\_sasl\_bind\_root\_pwd="password"
authentication\_ldap\_sasl\_bind\_base\_dn="cn=users,dc=MYSQL,dc=LOCAL"
authentication\_ldap\_sasl\_user\_search\_attr="sAMAccountName"

Create account\(s\) using Kerberos Authentication\.
For example:
CREATE USER 'bredon@MYSQL\.LOCAL'
  IDENTIFIED WITH authentication\_ldap\_sasl
  BY '\#krb\_grp=proxied\_krb\_user';

CREATE USER 'proxied\_krb\_user'
  IDENTIFIED WITH mysql\_no\_login;
GRANT ALL
  ON krb\_user\_db\.\*
  TO 'proxied\_krb\_user';

GRANT PROXY
  ON 'proxied\_krb\_user'
  TO 'bredon@MYSQL\.LOCAL’;```

**Check Text**:
```Verify that the MySQL is using Kerberos Authentication.  

On the server:
SELECT PLUGIN_NAME, PLUGIN_STATUS
       FROM INFORMATION_SCHEMA.PLUGINS
       WHERE PLUGIN_NAME LIKE '%ldap%';

On the client(s) where Kerberos will authenticate, check how long the ticket is cached.

First check whether Kerberos authentication works correctly:
Use kinit to authenticate to Kerberos, for example.
kinit bredon@MYSQL.LOCAL

The command authenticates for the Kerberos principal named bredon@MYSQL.LOCAL. Enter the principal's password when the command prompts for it. The KDC returns a TGT that is cached on the client side for use by other Kerberos-aware applications.
Use klist to check whether the TGT was obtained correctly. 

The output should be similar to this:
Ticket cache: FILE:/tmp/krb5cc_244306
Default principal: bredon@MYSQL.LOCAL
Valid starting                 Expires                           Service principal
03/23/2020 08:18:33  03/23/2020 18:18:33  krbtgt/MYSQL.LOCAL@MYSQL.LOCAL

If the ticket expiration time exceeds the desired maximum expiration, and Kerberos is enabled, check the LDAP server for the maximum lifetime of the Kerberos service Tickets expiration policy.  

If the lifetime exceeds the desired expiration time, this is a finding.```
