# V-235192 - The MySQL Database Server 8.0 must implement cryptographic mechanisms to prevent unauthorized modification of organization-defined information at rest (to include, at a minimum, PII and classified information) on organization-defined information system components.

**Severity**: medium

**Description**:
Database Management Systems (DBMSs) handling data requiring "data at rest" protections must employ cryptographic mechanisms to prevent unauthorized disclosure and modification of the information at rest. These cryptographic mechanisms may be native to the DBMS or implemented via additional software or operating system/file system settings, as appropriate to the situation.

Selection of a cryptographic mechanism is based on the need to protect the integrity of organizational information. The strength of the mechanism is commensurate with the security category and/or classification of the information. Organizations have the flexibility to either encrypt all information on storage devices (i.e., full disk encryption) or encrypt specific data structures (e.g., files, records, or fields).  

The decision whether and what to encrypt rests with the data owner and is also influenced by the physical measures taken to secure the equipment and media on which the information resides.

**Fix Text**:
```Configure the MySQL Database Server 8\.0, operating system/file system, and additional software as relevant, to provide the required level of cryptographic protection\.

Enable the MySQL Key Ring for securely managing encryption keys with KMIP or other supported protocols\.

Change TABLESPACES, TABLES to put in place encryption\.

ALTER TABLESPACE <tablespacename> ENCRYPTION = 'Y';
ALTER TABLE <tablespacename> ENCRYPTION = 'Y';

Require all new tables and tablespaces to be encrypted\.
set persist table\_encryption\_privilege\_check=ON;

Require AUDIT LOG encryption
sudo vi /etc/my\.cnf
\[mysqld\]
audit\-log=FORCE\_PLUS\_PERMANENT
audit\-log\-format=JSON
audit\-log\-encryption=AES

Require BINLOG encryption
set persist binlog\_encryption=ON;

Require REDO and UNDO log encryption
set persist innodb\_redo\_log\_encrypt=ON;
set persist innodb\_undo\_log\_encrypt=ON;

Turn off insecure logging \(use the audit log above to track activity\)\.
SET PERSIST general\_log = 'OFF';```

**Check Text**:
```Review the system documentation to determine whether the organization has defined the information at rest that is to be protected from modification, which must include, at a minimum, PII and classified information.

If no information is identified as requiring such protection, this is not a finding.

Review the configuration of the MySQL 8.0 Database Server, operating system/file system, and additional software as relevant.

If any of the information defined as requiring cryptographic protection from modification is not encrypted in a manner that provides the required level of protection, this is a finding.

To check for data encryption at rest settings in MySQL:
SELECT VARIABLE_NAME, VARIABLE_VALUE
FROM performance_schema.global_variables where variable_name = 'audit_log_encryption';
If the value for audit_log_encryption is not AES, this is a finding.

SELECT VARIABLE_NAME, VARIABLE_VALUE
FROM performance_schema.global_variables where variable_name = 'binlog_encryption'; 
If the value for binlog_encryption is not "ON", this is a finding.

SELECT VARIABLE_NAME, VARIABLE_VALUE
FROM performance_schema.global_variables where variable_name = 'innodb_redo_log_encrypt';
If the value for binlog_innodb_redo_log_encrypt is not "ON", this is a finding.

SELECT VARIABLE_NAME, VARIABLE_VALUE
FROM performance_schema.global_variables where variable_name = 'innodb_undo_log_encrypt';
If the value for innodb_undo_log_encrypt is not "ON", this is a finding.

SELECT VARIABLE_NAME, VARIABLE_VALUE
FROM performance_schema.global_variables where variable_name = 'table_encryption_privilege_check';
If the value for table_encryption_privilege_check is not "ON", this is a finding.

SELECT
    `INNODB_TABLESPACES`.`NAME`,
    `INNODB_TABLESPACES`.`ENCRYPTION`
FROM `information_schema`.`INNODB_TABLESPACES`;
If tables or tablespaces are not encrypted and the value is not "Y", this is a finding.```
