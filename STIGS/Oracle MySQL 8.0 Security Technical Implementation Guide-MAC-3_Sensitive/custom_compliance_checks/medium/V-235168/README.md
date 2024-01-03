# V-235168 - The MySQL Database Server 8.0 must prohibit user installation of logic modules (stored procedures, functions, triggers, views, etc.) without explicit privileged status.

**Severity**: medium

**Description**:
Allowing regular users to install software, without explicit privileges, creates the risk that untested or potentially malicious software will be installed on the system. Explicit privileges (escalated or administrative privileges) provide the regular user with explicit capabilities and control that exceed the rights of a regular user.

Database Management System (DBMS) functionality and the nature and requirements of databases will vary; so while users are not permitted to install unapproved software, there may be instances where the organization allows the user to install approved software packages such as from an approved software repository. The requirements for production servers will be more restrictive than those used for development and research.

The DBMS must enforce software installation by users based upon what types of software installations are permitted (e.g., updates and security patches to existing software) and what types of installations are prohibited (e.g., software whose pedigree with regard to being potentially malicious is unknown or suspect) by the organization. 

In the case of a DBMS, this requirement covers stored procedures, functions, triggers, views, etc.

**Fix Text**:
```MySQL requires users \(other than root\) to be explicitly granted the CREATE ROUTINE privilege in order to install logical modules\. 

Check user grants using the SHOW GRANTS and look for appropriate assignment of CREATE ROUTINE\. 

For example \- REVOKE CREATE ROUTINE ON mydb\.\* TO 'someuser'@'somehost';```

**Check Text**:
```MySQL requires users (other than root) to be explicitly granted the CREATE ROUTINE privilege in order to install logical modules.

To obtain a listing of users and roles who are authorized to create, alter, or replace stored procedures and functions from the server documentation.

Execute the following query:

For server level permissions
SELECT `user`.`Host`,
    `user`.`User`
FROM `mysql`.`user`
 where     `Create_routine_priv`='Y' OR
    `Alter_routine_priv` = 'Y';

If any users or role permissions returned are not authorized to modify the specified object or type, this is a finding. 

If any user or role membership is not authorized, this is a finding.

For database schema level permission (db is the schema name)
SELECT `db`.`Host`,
    `db`.`User`,
    `db`.`Db`
FROM `mysql`.`db` where     `db`.`Create_routine_priv`='Y' OR
    `db`.`Alter_routine_priv` = 'Y';

If any users or role permissions returned are not authorized to modify the specified object or type, this is a finding. 

If any user or role membership is not authorized, this is a finding.```
