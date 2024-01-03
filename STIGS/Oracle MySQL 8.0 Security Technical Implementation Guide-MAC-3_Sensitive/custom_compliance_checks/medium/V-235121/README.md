# V-235121 - The MySQL Database Server 8.0 must generate audit records when security objects are deleted.

**Severity**: medium

**Description**:
The removal of security objects from the database/Database Management System (DBMS) would seriously degrade a system's information assurance posture. If such an event occurs, it must be logged.

**Fix Text**:
```Configure the MySQL Database Server to audit when security objects are deleted\.

See the supplemental file "MySQL80Audit\.sql"\.```

**Check Text**:
```Review the system documentation to determine if MySQL Server is required to audit when security objects are deleted.

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

To check if the audit filters in place are generating records when security objects are deleted, run the following, which will test auditing. Note: This is destructive. Back up the database table prior to testing so it can be restored.
drop mysql.procs_priv; 

Review the audit log by running the Linux command:
sudo cat  <directory where audit log files are located>/audit.log|egrep DROP
For example if the values returned by - "select @@datadir, @@audit_log_file; " are  /usr/local/mysql/data/,  audit.log
sudo cat  /usr/local/mysql/data/audit.log |egrep DROP

The audit data will look similar to the example below: 
{ "timestamp": "2020-08-21 17:06:02", "id": 1, "class": "general", "event": "status", "connection_id": 9, "account": { "user": "root", "host": "localhost" }, "login": { "user": "root", "os": "", "ip": "::1", "proxy": "" }, "general_data": { "command": "Query", "sql_command": "drop_table", "query": "DROP TABLE `mysql`.`proxies_priv`", "status": 0 } },

If the audit event is not present, this is a finding.```
