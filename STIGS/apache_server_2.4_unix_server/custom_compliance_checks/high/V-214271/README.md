# V-214271 - The account used to run the Apache web server must not have a valid login shell and password defined.

**Severity**: high

**Description**:
During installation of the Apache web server software, accounts are created for the Apache web server to operate properly. The accounts installed can have either no password installed or a default password, which will be known and documented by the vendor and the user community.

The first things an attacker will try when presented with a logon screen are the default user identifiers with default passwords. Installed applications may also install accounts with no password, making the logon even easier. Once the Apache web server is installed, the passwords for any created accounts should be changed and documented. The new passwords must meet the requirements for all passwords, i.e., uppercase/lowercase characters, numbers, special characters, time until change, reuse policy, etc. 

Service accounts or system accounts that have no logon capability do not need to have passwords set or changed.

**Fix Text**:```
Update the /etc/passwd file to assign the account used to run the "httpd" process an invalid login shell such as "/sbin/nologin".

Lock the account used to run the "httpd" process:

# passwd -l <account>
Locking password for user <account>
passwd: Success
```
**Check Text**:
Identify the account that is running the "httpd" process:
# ps -ef | grep -i httpd | grep -v grep

apache   29613   996  0 Feb17 ?        00:00:00 /usr/sbin/httpd
apache   29614   996  0 Feb17 ?        00:00:00 /usr/sbin/httpd

Check to see if the account has a valid login shell:

# cut -d: -f1,7 /etc/passwd | grep -i <service_account>
apache:/sbin/nologin

If the service account has a valid login shell, verify that no password is configured for the account:

# cut -d: -f1,2 /etc/shadow | grep -i <service_account>
apache:!!

If the account has a valid login shell and a password defined, this is a finding.
