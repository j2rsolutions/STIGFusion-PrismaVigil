# V-235131 - The MySQL Database Server 8.0 must be able to generate audit records when successful accesses to objects occur.

**Severity**: medium

**Description**:
Without tracking all or selected types of access to all or selected objects (tables, views, procedures, functions, etc.), it would be difficult to establish, correlate, and investigate the events relating to an incident, or identify those responsible for one. 

In an SQL environment, types of access include, but are not necessarily limited to:
SELECT
INSERT
UPDATE
DELETE
EXECUTE

**Fix Text**:
```Configure the MySQL Database Server to audit when successful accesses to objects occur\. 

See the supplemental file "MySQL80Audit\.sql"\.```

**Check Text**:
```Review the system documentation to determine if MySQL Server is required to generate audit records when successful accesses to objects occur.

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

To check if the audit filters in place are generating records to audit when certain objects are accessed:

Run a query and other access types on that object.
select * from <schemaname>/<tablename>;

Review the audit log by running the Linux command:
sudo cat  <directory where audit log files are located>/audit.log|egrep <tablename>
For example if the values returned by "select @@datadir, @@audit_log_file; " are  /usr/local/mysql/data/,  audit.log 
sudo cat  /usr/local/mysql/data/audit.log |egrep <tablename>

If the audit event is not present, this is a finding.```
