# V-235136 - The MySQL Database Server 8.0 must map the PKI-authenticated identity to an associated user account.

**Severity**: medium

**Description**:
The DoD standard for authentication is DoD-approved PKI certificates. Once a PKI certificate has been validated, it must be mapped to a Database Management System (DBMS) user account for the authenticated identity to be meaningful to the DBMS and useful for authorization decisions.

**Fix Text**:
```Configure the MySQL Database Server 8\.0 to map the authenticated identity directly to the MySQL Database Server 8\.0 user account\.

Alter users to require X509 certificates\.

Below is an example to add X509 as a requirement\.

For a new user:
CREATE USER 'jeffrey'@'localhost' REQUIRE X509;
AND SUBJECT '/C=US/ST=Texas/L=Houston/O=SomeCompany/CN=Johan Smith'
  AND ISSUER '/C=US/ST=Texas/L=Houston/O=SomeCompany/CN=Some CA';

Or to add to an existing user:
ALTER USER 'johansmith'@'%'
REQUIRE X509
  AND SUBJECT '/C=US/ST=Texas/L=Houston/O=SomeCompany/CN=Johan Smith'
  AND ISSUER '/C=US/ST=Texas/L=Houston/O=SomeCompany/CN=Some CA';```

**Check Text**:
```Review MySQL Database Server 8.0 configuration to verify DBMS user accounts are being mapped directly to unique identifying information within the validated PKI certificate.

Confirm Issuer and Subject map to the username. Run the following script:
SELECT `user`.`Host`,
    `user`.`User`,
    `user`.`ssl_type`,
    CAST(`user`.`x509_issuer` as CHAR) as Issuer,
    CAST(`user`.`x509_subject` as CHAR) as Subject
FROM `mysql`.`user`;

If user accounts are not being mapped to authenticated identities, this is a finding.```
