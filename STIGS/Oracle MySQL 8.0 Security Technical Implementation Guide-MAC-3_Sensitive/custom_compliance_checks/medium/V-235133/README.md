# V-235133 - The MySQL Database Server 8.0 must generate audit records for all direct access to the database(s).

**Severity**: medium

**Description**:
In this context, direct access is any query, command, or call to the Database Management System (DBMS) that comes from any source other than the application(s) that it supports. Examples would be the command line or a database management utility program. The intent is to capture all activity from administrative and non-standard sources.

**Fix Text**:
```If currently required, configure the MySQL Database Server to produce audit records for all direct access to the database\(s\)\.

See the supplemental file "MySQL80Audit\.sql"\.```

**Check Text**:
```Review the system documentation to determine if MySQL Server is required to generate audit records for all direct access to the database(s).

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

To check if the audit filters in place are generating records to audit all direct access to the database(s):

Run any access to the database.

Review the audit log by running the Linux command:
sudo cat  <directory where audit log files are located>/audit.log
For example if the values returned by - "select @@datadir, @@audit_log_file; " are  /usr/local/mysql/data/,  audit.log 
sudo cat  /usr/local/mysql/data/audit.log

If the audit events are not present, this is a finding.```
