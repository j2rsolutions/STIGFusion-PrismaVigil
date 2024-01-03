# V-235161 - The MySQL Database Server 8.0 must protect its audit configuration from unauthorized modification.

**Severity**: medium

**Description**:
Protecting audit data also includes identifying and protecting the tools used to view and manipulate log data. Therefore, protecting audit tools is necessary to prevent unauthorized operation on audit data.

Applications providing tools to interface with audit data will leverage user permissions and roles identifying the user accessing the tools and the corresponding rights the user enjoys in order make access decisions regarding the modification of audit tools.

Audit tools include, but are not limited to, vendor-provided and open source audit tools needed to successfully view and manipulate audit information system activity and records. Audit tools include custom queries and report generators.

**Fix Text**:
```Remove audit\-related permissions from individuals and roles not authorized to have them\. 

REVOKE AUDIT\_ADMIN on \*\.\* FROM <user>;

Set audit log format to use AES encryption\.
sudo vi /etc/my\.cnf
\[mysqld\]
early\-plugin\-load=keyring\_file\.so
audit\-log=FORCE\_PLUS\_PERMANENT
audit\-log\-format=JSON
audit\-log\-encryption=AES

Note: First instantiate the keyring plugin which is needed to store the audit encryption key\.
The example above has an "early\-plugin\-load=keyring\_file\.so" entry in the my\.cnf file\.  
A keyring plugin must be present before adding the "audit\-log\-encryption=AES" entry or the database will not start\.

Below are valid key ring plugins: 

For dev test \- not encrypted
early\-plugin\-load=keyring\_file\.so

Encrypted file
early\-plugin\-load=keyring\_encrypted\_file\.so
keyring\_encrypted\_file\_data=/usr/local/mysql/mysql\-keyring/keyring\-encrypted
keyring\_encrypted\_file\_password=password

KMIP
early\-plugin\-load=keyring\_okv\.so
keyring\_okv\_conf\_dir=/usr/local/mysql/mysql\-keyring\-okv

Oracle Cloud Vault
early\-plugin\-load=keyring\_oci\.so
keyring\_oci\_user=ocid1\.user\.oc1\.\.longAlphaNumericString
keyring\_oci\_tenancy=ocid1\.tenancy\.oc1\.\.longAlphaNumericString
keyring\_oci\_compartment=ocid1\.compartment\.oc1\.\.longAlphaNumericString
keyring\_oci\_virtual\_vault=ocid1\.vault\.oc1\.iad\.shortAlphaNumericString\.longAlphaNumericString
keyring\_oci\_master\_key=ocid1\.key\.oc1\.iad\.shortAlphaNumericString\.longAlphaNumericString
keyring\_oci\_encryption\_endpoint=shortAlphaNumericString\-crypto\.kms\.us\-ashburn\-1\.oraclecloud\.com
keyring\_oci\_management\_endpoint=shortAlphaNumericString\-management\.kms\.us\-ashburn\-1\.oraclecloud\.com
keyring\_oci\_vaults\_endpoint=vaults\.us\-ashburn\-1\.oci\.oraclecloud\.com
keyring\_oci\_secrets\_endpoint=secrets\.vaults\.us\-ashburn\-1\.oci\.oraclecloud\.com
keyring\_oci\_key\_file=file\_name
keyring\_oci\_key\_fingerprint=12:34:56:78:90:ab:cd:ef:12:34:56:78:90:ab:cd:ef

Hashicorp
early\-plugin\-load=keyring\_hashicorp\.so
keyring\_hashicorp\_role\_id='ee3b495c\-d0c9\-11e9\-8881\-8444c71c32aa'
keyring\_hashicorp\_secret\_id='0512af29\-d0ca\-11e9\-95ee\-0010e00dd718'
keyring\_hashicorp\_store\_path='/v1/kv/mysql'```

**Check Text**:
```Check users with permissions to administer MySQL Auditing.

select * from information_schema.user_privileges where privilege_type = 'AUDIT_ADMIN';

If unauthorized accounts have the AUDIT_ADMIN privilege, this is a finding.

Check that a keyring plugin is installed.
SELECT * FROM information_schema.PLUGINS where plugin_name like 'keyring%';

If no keyring is installed, this is a finding.

Check if the audit files are encrypted.

To check for data encryption at rest settings in MySQL:
SELECT VARIABLE_NAME, VARIABLE_VALUE
FROM performance_schema.global_variables where variable_name = 'audit_log_encryption';

If "audit_log_encryption" is not set to "AES", this is a finding.```
