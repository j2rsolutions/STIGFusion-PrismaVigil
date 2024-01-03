# V-235120 - The MySQL Database Server 8.0 must generate audit records when unsuccessful attempts to delete privileges/permissions occur.

**Severity**: medium

**Description**:
Failed attempts to change the permissions, privileges, and roles granted to users and roles must be tracked. Without an audit trail, unauthorized attempts to elevate or restrict individuals and groups privileges could go undetected.   

In a SQL environment, deleting permissions is typically done via the REVOKE or DENY command. 

To aid in diagnosis, it is necessary to keep track of failed attempts in addition to the successful ones.

**Fix Text**:
```Configure the MySQL Database Server to audit when unsuccessful attempts to delete privileges/permissions occur\.

See the supplemental file "MySQL80Audit\.sql"\.```

**Check Text**:
```Review the system documentation to determine if MySQL Server is required to audit when unsuccessful attempts to delete privileges/permissions occur.

Check if MySQL audit is configured and enabled. The my.cnf file will set the variable audit_file.

To further check, execute the following query: 
SELECT PLUGIN_NAME, PLUGIN_STATUS
      FROM INFORMATION_SCHEMA.PLUGINS
      WHERE PLUGIN_NAME LIKE 'audit%';

The status of the audit_log plugin must be "active". If it is not "active", this is a finding.

Review audit filters and associated users by running the following queries:
SELECT `audit_log_filter`.`NAME`,
   `audit_log_filter`.`FILTER`
FROM `mysql`.`audit_log_filter`;

SELECT `audit_log_user`.`USER`,
   `audit_log_user`.`HOST`,
   `audit_log_user`.`FILTERNAME`
FROM `mysql`.`audit_log_user`;

All currently defined audits for the MySQL server instance will be listed. If no audits are returned, this is a finding.

To check if the audit filters in place are generating records when unsuccessful attempts to delete privileges/permissions occur, run the following, which will test auditing without destroying data but as a user without administrative privileges so that it fails:
delete from mysql.procs_priv where 1=2; 

Review the audit log by running the Linux command:
sudo cat  <directory where audit log files are located>/audit.log|egrep procs_priv
For example if the values returned by - "select @@datadir, @@audit_log_file; " are  /usr/local/mysql/data/,  audit.log
sudo cat  /usr/local/mysql/data/audit.log |egrep procs_priv

The audit data will look similar to the  example below and contain a non-zero status value:
{ "timestamp": "2020-08-19 21:24:26", "id": 2, "class": "general", "event": "status", "connection_id": 9, "account": { "user": "root", "host": "localhost" }, "login": { "user": "root", "os": "", "ip": "::1", "proxy": "" }, "general_data": { "command": "Query", "sql_command": "delete", "query": "delete from procs_priv", "status": 1142 } }

If the audit event is not present, this is a finding.```
