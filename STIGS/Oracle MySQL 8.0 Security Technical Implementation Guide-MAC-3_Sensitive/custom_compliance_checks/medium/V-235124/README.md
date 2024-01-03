# V-235124 - The MySQL Database Server 8.0 must generate audit records when unsuccessful attempts to delete categories of information (e.g., classification levels/security levels) occur.

**Severity**: medium

**Description**:
Changes in categories of information must be tracked. Without an audit trail, unauthorized access to protected data could go undetected.

To aid in diagnosis, it is necessary to keep track of failed attempts in addition to the successful ones.

For detailed information on categorizing information, refer to FIPS Publication 199, Standards for Security Categorization of Federal Information and Information Systems, and FIPS Publication 200, Minimum Security Requirements for Federal Information and Information Systems.

**Fix Text**:
```If currently required, configure the MySQL Database Server with delete triggers which prevent unauthorized deletes and call audit\_api\_message\_emit\_udf\(\) function  to produce audit records when unsuccessful attempts to delete categories of information occur\.
Add security level details in an additional column\.

Add the component for adding information to the audit log\.

INSTALL COMPONENT "file://component\_audit\_api\_message\_emit”;
create schema test\_trigger;

Create a stored procedure to allow the audit\_api\_message\_emit\_udf to be called as well as providing the details for the audit event\.

DELIMITER $$

CREATE PROCEDURE audit\_api\_message\_emit\_sp\(name CHAR\(20\)\)
BEGIN
	DECLARE aud\_msg VARCHAR\(255\);
	select audit\_api\_message\_emit\_udf\('sec\_level\_trigger',
                                         'TRIGGER audit\_delete\_attempt',
                                         'Attempt was made to delete H level sec data',
                                         'FOR ', name
                                         \) into aud\_msg;
END$$
DELIMITER ;```

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

Create MySQL Delete triggers that check for changes to categories of information. If the trigger before data indicates an attempt to delete such information, the trigger should be written to prevent the delete as well as optionally write to the MySQL Audit by calling the audit_api_message_emit_udf() function and including the details related to the attempt. Note: To call from a trigger requires a minimal stored procedure as well.

Once the trigger has been created, check if the audit filters that are in place are generating records when categories of information are deleted.

- An Example test -

CREATE TABLE `test_trigger`.`info_cat_test` (
  `id` INT NOT NULL,
  `name` VARCHAR(20) NULL,
  `desc` VARCHAR(20) NULL,
  `sec_level` CHAR(1) NULL,
  PRIMARY KEY (`id`));

DELIMITER $$

CREATE TRIGGER test_trigger.audit_delete_attempt
    BEFORE DELETE ON `test_trigger`.`info_cat_test`
    FOR EACH ROW
BEGIN
    IF OLD.sec_level = 'H' THEN
	    CALL audit_api_message_emit_sp(OLD.name);
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR - THIS DATA IS LEVEL H';
    END IF;
END$$
DELIMITER ;


INSERT INTO `test_trigger`.`info_cat_test` (`id`, `name`, `desc`, `sec_level`) VALUES ('1', 'fred', 'engineer', 'H');
INSERT INTO `test_trigger`.`info_cat_test` (`id`, `name`, `desc`, `sec_level`) VALUES ('2', 'jill', 'program manager', 'M');
INSERT INTO `test_trigger`.`info_cat_test` (`id`, `name`, `desc`, `sec_level`) VALUES ('3', 'joe', 'maintenance', 'L');

delete from `test_trigger`.`info_cat_test` where id=1;
// this fails as the trigger defines that sec_level of H can not be deleted.

delete from `test_trigger`.`info_cat_test` where id=2;
delete from `test_trigger`.`info_cat_test` where id=3;

Review the audit log by running the Linux command:
sudo cat  <directory where audit log files are located>/audit.log | egrep sec_level_trigger
For example if the values returned by - "select @@datadir, @@audit_log_file; " are  /usr/local/mysql/data/,  audit.log
sudo cat  /usr/local/mysql/data/audit.log |egrep sec_level_trigger

If the audit event is not present, this is a finding.```
