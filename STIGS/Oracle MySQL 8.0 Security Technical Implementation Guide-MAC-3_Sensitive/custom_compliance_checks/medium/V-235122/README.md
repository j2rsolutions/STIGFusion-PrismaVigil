# V-235122 - The MySQL Database Server 8.0 must generate audit records when unsuccessful attempts to delete security objects occur.

**Severity**: medium

**Description**:
The removal of security objects from the database/Database Management System (DBMS) would seriously degrade a system's information assurance posture. If such an action is attempted, it must be logged.

To aid in diagnosis, it is necessary to keep track of failed attempts in addition to the successful ones.

**Fix Text**:
```Configure the MySQL Database Server to audit when unsuccessful attempts to delete security objects occur\.

See the supplemental file "MySQL80Audit\.sql"\.```

**Check Text**:
```Review the system documentation to determine if MySQL Server is required to audit when unsuccessful attempts to delete security objects occur.

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

To check if the audit filters in place are generating records when security objects are deleted, run the following, which will test auditing as a user with administrator-level privileges:
drop table mysql.columns_priv;
ERROR: 1142: DROP command denied to user 'newuser'@'localhost' for table 'columns_priv'

Review the audit log by running the Linux command:
sudo cat  <directory where audit log files are located>/audit.log|egrep DROP
For example if the values returned by - "select @@datadir, @@audit_log_file; " are  /usr/local/mysql/data/,  audit.log
sudo cat  /usr/local/mysql/data/audit.log |egrep DROP

The audit data will look similar to the example below and contain a non-zero status value:
{ "timestamp": "2020-08-21 17:21:12", "id": 0, "class": "general", "event": "status", "connection_id": 17, "account": { "user": "newuser", "host": "localhost" }, "login": { "user": "newuser", "os": "", "ip": "::1", "proxy": "" }, "general_data": { "command": "Query", "sql_command": "drop_table", "query": "drop table `mysql`.audit_log_user", "status": 1142 } },

If the audit event is not present, this is a finding.```
