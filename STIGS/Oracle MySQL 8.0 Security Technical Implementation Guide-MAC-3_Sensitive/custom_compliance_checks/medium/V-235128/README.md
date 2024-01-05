# V-235128 - The MySQL Database Server 8.0 must generate audit records when unsuccessful attempts to execute privileged activities or other system-level access occur.

**Severity**: medium

**Description**:
Without tracking privileged activity, it would be difficult to establish, correlate, and investigate the events relating to an incident or identify those responsible for one. 

System documentation should include a definition of the functionality considered privileged.

A privileged function in this context is any operation that modifies the structure of the database, its built-in logic, or its security settings. This would include all Data Definition Language (DDL) statements and all security-related statements. In an SQL environment, it encompasses, but is not necessarily limited to:
CREATE
ALTER
DROP
GRANT
REVOKE
DENY

Note that it is particularly important to audit, and tightly control, any action that weakens the implementation of this requirement itself, since the objective is to have a complete audit trail of all administrative activity.

To aid in diagnosis, it is necessary to keep track of failed attempts in addition to the successful ones.

**Fix Text**:
```Configure the MySQL Database Server to audit for unsuccessful attempts to execute privileged activities or other system\-level access\.

Add the following events to the MySQL Server Audit: 
grant
grant\_roles
revoke
revoke\_all
revoke\_roles
drop\_role
alter\_user\_default\_role
create\_role
drop\_role
grant\_roles
revoke\_roles
set\_role
create\_user
alter\_user
drop\_user
alter\_user
alter\_user\_default\_role
create\_user
drop\_user
rename\_user
show\_create\_user

See the supplemental file "MySQL80Audit\.sql"\.```

**Check Text**:
```Review the system documentation to determine if MySQL Server is required to audit for unsuccessful attempts to execute privileged activities or other system-level access.

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

Determine if rules are in place to capture the following types of commands related to permissions by running:

select * from mysql.audit_log_filter;

If the template SQL filter was used, it will have the name log_stig.

Review the filter values it will show filters for events of type of the field general_sql_command.str for the following SQL statement types:
grant
grant_roles
revoke
revoke_all
revoke_roles
drop_role
alter_user_default_role
create_role
drop_role
grant_roles
revoke_roles
set_role
create_user
alter_user
drop_user
alter_user
alter_user_default_role
create_user
drop_user
rename_user
show_create_user```
