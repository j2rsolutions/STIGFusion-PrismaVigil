# V-235111 - The MySQL Database Server 8.0 must generate audit records when privileges/permissions are added.

**Severity**: medium

**Description**:
Changes in the permissions, privileges, and roles granted to users and roles must be tracked. Without an audit trail, unauthorized elevation or restriction of individuals and groups privileges could go undetected. Elevated privileges give users access to information and functionality that they must not have; restricted privileges wrongly deny access to authorized users.

In a SQL environment, adding permissions is typically done via the GRANT command, or, in the negative, the DENY command.

**Fix Text**:
```Configure the MySQL Database Server to audit when privileges/permissions are added\.

Add the following events to the MySQL Server Audit being used for the STIG compliance audit: 
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
```Check that MySQL Server Audit is being used for the STIG compliant audit.

Check if MySQL audit is configured and enabled. The my.cnf file will set the variable audit_file.

To further check, execute the following query: 
SELECT PLUGIN_NAME, PLUGIN_STATUS
      FROM INFORMATION_SCHEMA.PLUGINS
      WHERE PLUGIN_NAME LIKE 'audit%';

The status of the audit_log plugin should be "active". If it is not "active", this is a finding.

Review audit filters and associated users by running the following queries:
SELECT `audit_log_filter`.`NAME`,
   `audit_log_filter`.`FILTER`
FROM `mysql`.`audit_log_filter`;

SELECT `audit_log_user`.`USER`,
   `audit_log_user`.`HOST`,
   `audit_log_user`.`FILTERNAME`
FROM `mysql`.`audit_log_user`;

All currently defined audits for the MySQL server instance will be listed. If no audits are returned, this is a finding.

Determine if rules are in place to capture the following types of commands related to permissions by running the command:
select * from mysql.audit_log_filter;

If the template SQL filter was used, it will have the name log_stig.

Review the filter value. It will show filters for events of the  type field general_sql_command.str for the following SQL statement types:
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
