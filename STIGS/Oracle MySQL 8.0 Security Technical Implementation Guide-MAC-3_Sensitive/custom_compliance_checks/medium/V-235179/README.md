# V-235179 - The MySQL Database Server 8.0 must enforce discretionary access control policies, as defined by the data owner, over defined subjects and objects.

**Severity**: medium

**Description**:
Discretionary Access Control (DAC) is based on the notion that individual users are "owners" of objects and therefore have discretion over who should be authorized to access the object and in which mode (e.g., read or write). Ownership is usually acquired as a consequence of creating the object or via specified ownership assignment. DAC allows the owner to determine who will have access to objects they control. An example of DAC includes user-controlled table permissions.

When discretionary access control policies are implemented, subjects are not constrained with regard to what actions they can take with information for which they have already been granted access. Thus, subjects that have been granted access to information are not prevented from passing (i.e., the subjects have the discretion to pass) the information to other subjects or objects. 

A subject that is constrained in its operation by Mandatory Access Control policies is still able to operate under the less rigorous constraints of this requirement. Thus, while Mandatory Access Control imposes constraints preventing a subject from passing information to another subject operating at a different sensitivity level, this requirement permits the subject to pass the information to any subject at the same sensitivity level. 

The policy is bounded by the information system boundary. Once the information is passed outside of the control of the information system, additional means may be required to ensure the constraints remain in effect. While the older, more traditional definitions of discretionary access control require identity-based access control, that limitation is not required for this use of discretionary access control.

**Fix Text**:
```To correct object ownership:

To revoke any unauthorized permissions:

REVOKE
    priv\_type \[\(column\_list\)\]
      \[, priv\_type \[\(column\_list\)\]\] \.\.\.
    ON \[object\_type\] priv\_level
    FROM user\_or\_role \[, user\_or\_role\] \.\.\.

REVOKE ALL \[PRIVILEGES\], GRANT OPTION
    FROM user\_or\_role \[, user\_or\_role\] \.\.\.

REVOKE PROXY ON user\_or\_role
    FROM user\_or\_role \[, user\_or\_role\] \.\.\.

REVOKE role \[, role \] \.\.\.
    FROM user\_or\_role \[, user\_or\_role \] \.\.\.```

**Check Text**:
```Use the following query to discover database object access rights:

Users with DDL rights on database objects
At Instance Level
SELECT *
FROM `mysql`.`user`
WHERE  (`mysql`.`user`.`user` not like 'mysql.%')  AND (
    `user`.`Create_priv` = 'Y' OR
    `user`.`Drop_priv` = 'Y' OR
    `user`.`Grant_priv` = 'Y' OR
    `user`.`References_priv` = 'Y' OR
    `user`.`Index_priv` = 'Y' OR
    `user`.`Alter_priv` = 'Y' OR
    `user`.`Super_priv` = 'Y' OR
    `user`.`Execute_priv` = 'Y' OR
    `user`.`Create_view_priv` = 'Y' OR
    `user`.`Create_routine_priv` = 'Y' OR
    `user`.`Alter_routine_priv` = 'Y' OR
    `user`.`Create_user_priv` = 'Y' OR
    `user`.`Event_priv` = 'Y' OR
    `user`.`Trigger_priv` = 'Y' OR
    `user`.`Create_role_priv` = 'Y' OR
    `user`.`Drop_role_priv` = 'Y') ;

At DB/Schema Level - Users with DDL rights on database objects
Ensure only administrative users are returned in the result set.
SELECT * FROM mysql.db where
    (`db`.`Grant_priv` = 'Y' OR
    `db`.`References_priv`= 'Y' OR
    `db`.`Index_priv`= 'Y' OR
    `db`.`Alter_priv`= 'Y' OR
    `db`.`Create_tmp_table_priv`= 'Y' OR
    `db`.`Lock_tables_priv`= 'Y' OR
    `db`.`Create_view_priv`= 'Y' OR
    `db`.`Show_view_priv`= 'Y' OR
    `db`.`Create_routine_priv`= 'Y' OR
    `db`.`Alter_routine_priv`= 'Y' OR
    `db`.`Execute_priv`= 'Y' OR
    `db`.`Event_priv`= 'Y' OR
    `db`.`Trigger_priv`) and user not like 'mysql.%';

Ensure only administrative users are returned in the result set.

Use the following query to discover database users who have been delegated the right to grant permissions to other users:

Execute the following SQL statements to audit this setting:
SELECT `USER_PRIVILEGES`.`GRANTEE`,
    `USER_PRIVILEGES`.`TABLE_CATALOG`,
    `USER_PRIVILEGES`.`PRIVILEGE_TYPE`,
    `USER_PRIVILEGES`.`IS_GRANTABLE`
FROM `information_schema`.`USER_PRIVILEGES`
where `USER_PRIVILEGES`.`IS_GRANTABLE`='YES';

Ensure only administrative users are returned in the result set.

If any of these rights are not documented and authorized, this is a finding.```
