# V-235103 - The MySQL Database Server 8.0 must be configured to provide audit record generation capability for DoD-defined auditable events within all database components.

**Severity**: medium

**Description**:
Without the capability to generate audit records, it would be difficult to establish, correlate, and investigate the events relating to an incident or identify those responsible for one. 

Audit records can be generated from various components within the Database Management System (DBMS) (e.g., process, module). Certain specific application functionalities may be audited as well. The list of audited events is the set of events for which audits are to be generated. This set of events is typically a subset of the list of all events for which the system is capable of generating audit records.

DoD has defined the list of events for which the DBMS will provide an audit record generation capability as the following: 

(i) Successful and unsuccessful attempts to access, modify, or delete privileges, security objects, security levels, or categories of information (e.g., classification levels);

(ii) Access actions, such as successful and unsuccessful logon attempts, privileged activities, or other system-level access, starting and ending time for user access to the system, concurrent logons from different workstations, successful and unsuccessful accesses to objects, all program initiations, and all direct access to the information system; and

(iii) All account creation, modification, disabling, and termination actions.

Organizations may define additional events requiring continuous or ad hoc auditing.

**Fix Text**:
```Deploy a MySQL Database Server 8\.0 that supports the DoD minimum set of auditable events\.

Configure the MySQL Database Server 8\.0 to generate audit records for at least the DoD minimum set of events\.

sudo vi /etc/my\.cnf
\[mysqld\]
audit\-log=FORCE\_PLUS\_PERMANENT
audit\-log\-format=JSON
audit\-log\-encryption=AES

After changing the my\.cnf, restart the server\.

SELECT audit\_log\_encryption\_password\_set\(password\);

Create auditing rules \- for example:
Connect to MySQL and Use functions to define audit rules and audited users  audit\_log\_filter\_set,audit\_log\_filter\_set\_user

To log all auditable events:
SELECT audit\_log\_filter\_set\_filter\('log\_all', '\{ "filter": \{ "log": true \} \}'\);

And to apply this log\_all filter to all users:
SELECT audit\_log\_filter\_set\_user\('%', 'log\_all'\);```

**Check Text**:
```Check MySQL auditing to determine whether organization-defined auditable events are being audited by the system.

SELECT PLUGIN_NAME, plugin_status FROM INFORMATION_SCHEMA.PLUGINS
       WHERE PLUGIN_NAME LIKE 'audit_log' ;

If nothing is returned OR if the results are not "audit_log" and "plugin_status='ACTIVE'" , this is a finding.

Next determine if the audit lot is encrypted. 
SELECT VARIABLE_NAME, VARIABLE_VALUE
FROM performance_schema.global_variables
WHERE VARIABLE_NAME LIKE 'audit_log_encryption' ;

If nothing is returned OR the value for audit_log_encryption is not "AES", this is a finding.```
