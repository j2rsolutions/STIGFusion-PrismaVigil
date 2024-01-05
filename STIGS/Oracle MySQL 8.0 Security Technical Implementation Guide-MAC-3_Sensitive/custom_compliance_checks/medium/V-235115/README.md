# V-235115 - The MySQL Database Server 8.0 must generate audit records when security objects are modified.

**Severity**: medium

**Description**:
Changes in the database objects (tables, views, procedures, functions) that record and control permissions, privileges, and roles granted to users and roles must be tracked. Without an audit trail, unauthorized changes to the security subsystem could go undetected. The database could be severely compromised or rendered inoperative.

**Fix Text**:
```If currently required, configure the MySQL Database Server to produce audit records when security objects are modified\.

See the supplemental file "MySQL80Audit\.sql"\.```

**Check Text**:
```Review the system documentation to determine if MySQL Server is required to audit when security objects are modified.

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

To check if the audit filters that are in place are generating records when security objects are modified, run the following, which will test auditing without destroying data:
update mysql.global_grants set host='%' where PRIV='XXXX’;

Review the audit log by running the Linux command:
sudo cat  <directory where audit log files are located>/audit.log|egrep global_grants
For example if the values returned by "select @@datadir, @@audit_log_file; " are  /usr/local/mysql/data/,  audit.log
sudo cat  /usr/local/mysql/data/audit.log |egrep global_grants
For example if the values returned by "select @@datadir, @@audit_log_file; " are  /usr/local/mysql/data/,  audit.log
sudo cat  /usr/local/mysql/data/audit.log |egrep global_grants

The audit data will look similar to the example below:
{ "timestamp": "2020-08-19 21:32:27", "id": 2, "class": "general", "event": "status", "connection_id": 9, "account": { "user": "root", "host": "localhost" }, "login": { "user": "root", "os": "", "ip": "::1", "proxy": "" }, "general_data": { "command": "Query", "sql_command": "update", "query": "update mysql.global_grants set host='%' where PRIV='XXXX'", "status": 0 } }

If the audit event is not present, this is a finding.```
