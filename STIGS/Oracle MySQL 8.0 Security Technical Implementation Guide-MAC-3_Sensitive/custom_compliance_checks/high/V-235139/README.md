# V-235139 - If passwords are used for authentication, the MySQL Database Server 8.0 must transmit only encrypted representations of passwords.

**Severity**: high

**Description**:
The DoD standard for authentication is DoD-approved PKI certificates.

Authentication based on User ID and Password may be used only when it is not possible to employ a PKI certificate, and requires Authorizing Official (AO) approval.

In such cases, passwords need to be protected at all times, and encryption is the standard method for protecting passwords during transmission.

Database Management System (DBMS) passwords sent in clear text format across the network are vulnerable to discovery by unauthorized users. Disclosure of passwords may easily lead to unauthorized access to the database.

**Fix Text**:
```Configure encryption for transmission of passwords across the network\. If the database does not provide encryption for logon events natively, employ encryption at the OS or network level\.

Ensure passwords remain encrypted from source to destination\.

connect to MySQL as admin \(root\)
mysql> set persist require\_secure\_transport=ON;

Set system variables on the server side specify  DoD approved certificate and key files the server uses when permitting clients to establish encrypted connections:

ssl\_ca: The path name of the Certificate Authority \(CA\) certificate file\. \(ssl\_capath is similar but specifies the path name of a directory of CA certificate files\.\)

ssl\_cert: The path name of the server public key certificate file\. This certificate can be sent to the client and authenticated against the CA certificate that it has\.

ssl\_key: The path name of the server private key file\.

For example, to enable the server for encrypted connections with certificates, start it with these lines in the my\.cnf file, changing the file names as necessary:

\[mysqld\]
ssl\_ca=ca\.pem
ssl\_cert=server\-cert\.pem
ssl\_key=server\-key\.pem```

**Check Text**:
```Review configuration settings for encrypting passwords in transit across the network. If passwords are not encrypted, this is a finding. 

If it is determined that passwords are passed unencrypted at any point along the transmission path between the source and destination, this is a finding.

To check, run the following SQL:
SELECT VARIABLE_NAME, VARIABLE_VALUE
FROM performance_schema.global_variables
WHERE VARIABLE_NAME IN ('require_secure_transport') ;
If the require_secure_transport VARIABLE_VALUE is not  'ON' (1), this is a finding.

 If 1 (On), then only SSL connections are permitted; next examine the certificate used.

Run the following command to determine the certificate in use along with other details:
select @@ssl_ca, @@ssl_capath, @@ssl_cert, @@ssl_cipher, @@ssl_crl, @@ssl_crlpath, @@ssl_fips_mode, @@ssl_key;

If the certificate is not a DoD certificate, or if no certificate is listed, this is a finding.```
