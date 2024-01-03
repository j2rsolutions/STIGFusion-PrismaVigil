# V-235109 - The MySQL Database Server 8.0 must generate audit records when categories of information (e.g., classification levels/security levels) are accessed.

**Severity**: medium

**Description**:
Changes in categories of information must be tracked. Without an audit trail, unauthorized access to protected data could go undetected.

For detailed information on categorizing information, refer to FIPS Publication 199, Standards for Security Categorization of Federal Information and Information Systems, and FIPS Publication 200, Minimum Security Requirements for Federal Information and Information Systems.

**Fix Text**:
```If currently required, configure the MySQL Database Server with stored procedures that use selects that call audit\_api\_message\_emit\_udf\(\) function to produce audit records when selection of categories of information occurs\.
Add security level details in an additional column\.

Add the component for adding information to the audit log\.

INSTALL COMPONENT "file://component\_audit\_api\_message\_emit”;
create schema test\_trigger;

Modify selections adding the audit\_api\_message\_emit\_udf to be called, as well as providing the details for the audit event\.

Transparently enforcing the use of MySQL stored procedures is required\.

See the supplemental file "MySQL80Audit\.sql"\.```

**Check Text**:
```If classification levels/security levels labeling is not required, this is not a finding.

Review the system documentation to determine if MySQL Server is required to audit records when unsuccessful attempts to delete categories of information (e.g., classification levels/security levels) occur.

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

Modify MySQL selects that check for changes to categories of information. Modify selects statements to audit when information categories are accessed using MySQL Audit by calling the audit_api_message_emit_udf() function and including the details related to the select. 

- An Example test -

CREATE TABLE `test_trigger`.`info_cat_test` (
  `id` INT NOT NULL,
  `name` VARCHAR(20) NULL,
  `desc` VARCHAR(20) NULL,
  `sec_level` CHAR(1) NULL,
  PRIMARY KEY (`id`));

DELIMITER $$


INSERT INTO `test_trigger`.`info_cat_test` (`id`, `name`, `desc`, `sec_level`) VALUES ('1', 'fred', 'engineer', 'H');
INSERT INTO `test_trigger`.`info_cat_test` (`id`, `name`, `desc`, `sec_level`) VALUES ('2', 'jill', 'program manager', 'M');
INSERT INTO `test_trigger`.`info_cat_test` (`id`, `name`, `desc`, `sec_level`) VALUES ('3', 'joe', 'maintenance', 'L');

SELECT `info_cat_test`.`id`,
    `info_cat_test`.`name`,
    `info_cat_test`.`desc`,
    `info_cat_test`.`sec_level`,
    IF(`info_cat_test`.`sec_level`= 'H', 
    audit_api_message_emit_udf('sec_level_selected',
                                         'audit_select_attempt',
                                         ' H level sec data was accessed',
                                         'FOR ', name
                                         ), 
    'Not Audited')
FROM `test_trigger`.`info_cat_test`;

Review the audit log by running the Linux command:
sudo cat  <directory where audit log files are located>/audit.log | egrep sec_level_selected
For example if the values returned by - "select @@datadir, @@audit_log_file; " are  /usr/local/mysql/data/,  audit.log
sudo cat  /usr/local/mysql/data/audit.log |egrep sec_level_priv

The audit data will look similar to the example below:
{ "timestamp": "2020-08-20 21:19:21", "id": 1, "class": "message", "event": "user", "connection_id": 9, "account": { "user": "root", "host": "localhost" }, "login": { "user": "root", "os": "", "ip": "::1", "proxy": "" }, "message_data": { "component": "sec_level_selected", "producer": "audit_select_attempt", "message": " H level sec data was accessed", "map": { "FOR ": "fred" } } },

If the audit event is not present, this is a finding.```
