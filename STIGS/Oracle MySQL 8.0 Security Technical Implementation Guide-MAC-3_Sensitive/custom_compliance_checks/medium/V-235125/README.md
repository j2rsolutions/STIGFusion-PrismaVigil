# V-235125 - The MySQL Database Server 8.0 must generate audit records when successful logons or connections occur.

**Severity**: medium

**Description**:
For completeness of forensic analysis, it is necessary to track who/what (a user or other principal) logs on to the Database Management System (DBMS).

**Fix Text**:
```If currently required, configure the MySQL Database Server to produce audit records when successful logons or connections occur\.

See the supplemental file "MySQL80Audit\.sql"\.```

**Check Text**:
```Review the system documentation to determine if MySQL Server is required to audit when successful logons or connections occur.

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

To check if the audit filters in place are generating records when successful logons or connections occur, log in to MySQL and then log out. Below is an example using MySQL Shell:
% mysqlsh —sql
 MySQL  SQL > \connect newuser@localhost
Creating a session to 'newuser@localhost'
 MySQL  localhost:33060+ ssl  SQL > \quit
Bye!

Review the audit log by running the Linux command:
Note, "status": 0 for each indicates successful.

sudo cat  <directory where audit log files are located>/audit.log | egrep  "\"event\": \”connect\""
For example if the values returned by - "select @@datadir, @@audit_log_file; " are  /usr/local/mysql/data/,  audit.log
sudo cat  /usr/local/mysql/data/audit.log |egrep  "\"event\": \”connect\""

The audit data will look similar to the example below:
Logging in - connecting

{ "timestamp": "2020-08-21 17:47:09", "id": 0, "class": "connection", "event": "connect", "connection_id": 19, "account": { "user": "newuser", "host": "localhost" }, "login": { "user": "newuser", "os": "", "ip": "::1", "proxy": "" }, "connection_data": { "connection_type": "plugin", "status": 0, "db": "" } },

Logging out - disconnection

sudo cat  <directory where audit log files are located>/audit.log | egrep  "\"event\": \"disconnect\”"

Example output:
{ "timestamp": "2020-08-21 17:47:11", "id": 1, "class": "connection", "event": "disconnect", "connection_id": 19, "account": { "user": "newuser", "host": "localhost" }, "login": { "user": "newuser", "os": "", "ip": "::1", "proxy": "" }, "connection_data": { "connection_type": "plugin" } },```
