# V-235187 - The MySQL Database Server 8.0 must use NSA-approved cryptography to protect classified information in accordance with the data owner's requirements.

**Severity**: medium

**Description**:
Use of weak or untested encryption algorithms undermines the purposes of utilizing encryption to protect data. The application must implement cryptographic modules adhering to the higher standards approved by the federal government since this provides assurance they have been tested and validated.

It is the responsibility of the data owner to assess the cryptography requirements in light of applicable federal laws, Executive Orders, directives, policies, regulations, and standards.

NSA-approved cryptography for classified networks is hardware based. This requirement addresses the compatibility of a DBMS with the encryption devices.

**Fix Text**:
```Configure cryptographic functions to use NSA\-approved cryptography\-compliant algorithms\.

Turn on MySQL FIPS mode\.
Edit my\.cnf
\[mysqld\]
ssl\_fips\_mode=ON

or
\[mysqld\]
ssl\_fips\_mode=STRICT

To restrict TLS versions:

\[mysqld\]
tls\_version='TLSv1\.2,TLSv1\.3'

Example to define ciphers for TLSv1\.2:

\[mysqld\]
ssl\_ciphers='ECDHE\-ECDSA\-AES128\-GCM\-SHA256:ECDHE\-ECDSA\-AES256\-GCM\-SHA384:ECDHE\-RSA\-AES128\-GCM\-SHA256:ECDHE\-RSA\-AES256\-GCM\-SHA384:DHE\-RSA\-AES128\-GCM\-SHA256:DHE\-DSS\-AES128\-GCM\-SHA256:DHE\-DSS\-AES256\-GCM\-SHA384:DHE\-RSA\-AES256\-GCM\-SHA384:ECDHE\-ECDSA\-CHACHA20\-POLY1305:ECDHE\-RSA\-CHACHA20\-POLY1305'

If TLSv1\.3 is enabled, the "tls\_ciphersuites" setting must contain all or a subset of the following ciphers based on certificates being used by server and client\. Enabling FIPS mode will limit the OpenSSL library to operate within the FIPS object module\.

Example to define TLS ciphers for TLSv1\.3:

\[mysqld\]
tls\_ciphersuites='TLS\_AES\_128\_GCM\_SHA256:TLS\_AES\_256\_GCM\_SHA384:TLS\_CHACHA20\_POLY1305\_SHA256:TLS\_AES\_128\_CCM\_SHA256:TLS\_AES\_128\_CCM\_8\_SHA256'

After adding any entries to the my\.cnf file, restart mysqld\.

Create and use DOD\-approved certificates for asymmetric keys used by the database\.```

**Check Text**:
```Detailed information on the NIST Cryptographic Module Validation Program (CMVP) is available at the following website: http://csrc.nist.gov/groups/STM/cmvp/index.html.

Review system documentation to determine whether cryptography for classified or sensitive information is required by the information owner.

If the system documentation does not specify the type of information hosted on MySQL: classified, sensitive, and/or unclassified, this is a finding.

If classified or sensitive information does not exist within MySQL Server, this is not a finding.

Verify that the operating system provides the OpenSSL FIPS Object Module, and is configured to require the use of OpenSSL of FIPS compliant algorithms, available at MySQL runtime.

If the Security Setting for FIPS mode option is "Disabled" on the server's OS, this is a finding.

If cryptography is being used by MySQL, verify that the cryptography is NIST FIPS certified by running the following SQL query:
Determine if MySQL is running in FIPS mode.
select @@ssl_fips_mode;

If ssl_fips_mode is not "ON" or "STRICT", this is a finding.

View the versions of TLS, then review the cipher suites in use for the versions returned by statement:
SELECT VARIABLE_NAME, VARIABLE_VALUE
FROM performance_schema.global_variables WHERE VARIABLE_NAME = 'tls_version';

If the results include less than version TLS 1.2, for example TLS 1.0 or 1.1, this is a finding. 

If the results include TLS 1.2 view the supported ciphers on the MySQL Server, run
select * from performance_schema.global_status where variable_name= 'Ssl_cipher_list';

If the results include TLS 1.3 view the supported ciphers on the MySQL Server, run
SELECT VARIABLE_NAME, VARIABLE_VALUE
FROM performance_schema.global_variables WHERE VARIABLE_NAME = 'tls_ciphersuites';

If any results list show an uncertified NIST FIPS 140-2 algorithm type, this is a finding.

Check MySQL certificate PEM file(s) for compliance with DoD requirements by running this command: 
openssl x509 -in server-cert.pem -text -noout

If any PEM file is not in compliance, this is a finding.```
