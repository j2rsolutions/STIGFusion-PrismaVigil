# V-235159 - The MySQL Database Server 8.0 must initiate session auditing upon startup.

**Severity**: medium

**Description**:
Session auditing is for use when a user's activities are under investigation. To be sure of capturing all activity during those periods when session auditing is in use, it needs to be in operation for the whole time the Database Management System (DBMS) is running.

**Fix Text**:
```Configure the MySQL Audit to automatically start during system startup\.  
Add to the my\.cnf: 

\[mysqld\]
plugin\-load\-add=audit\_log\.so
audit\-log=FORCE\_PLUS\_PERMANENT
audit\-log\-format=JSON```

**Check Text**:
```Determine if an audit is configured and enabled. 

The my.cnf file will set the variable audit_file.

Review the my.cnf file for the following entries:
[mysqld]
plugin-load-add=audit_log.so
audit-log=FORCE_PLUS_PERMANENT

If these entries are not present. This is a finding.

Execute the following query: 
SELECT PLUGIN_NAME, PLUGIN_STATUS
       FROM INFORMATION_SCHEMA.PLUGINS
       WHERE PLUGIN_NAME LIKE 'audit%';

The status of the "audit_log plugin" must be "active". If it is not "active", this is a finding.

Review audit filters and associated users by running the following queries:
SELECT `audit_log_filter`.`NAME`,
    `audit_log_filter`.`FILTER`
FROM `mysql`.`audit_log_filter`;

SELECT `audit_log_user`.`USER`,
    `audit_log_user`.`HOST`,
    `audit_log_user`.`FILTERNAME`
FROM `mysql`.`audit_log_user`;

All currently defined audits for the MySQL server instance will be listed. If no audits are returned, this is a finding.```
