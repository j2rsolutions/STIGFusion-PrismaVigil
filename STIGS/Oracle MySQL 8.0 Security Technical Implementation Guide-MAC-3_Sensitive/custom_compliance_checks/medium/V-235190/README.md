# V-235190 - The MySQL Database Server 8.0 must implement NIST FIPS 140-2 or 140-3 validated cryptographic modules to protect unclassified information requiring confidentiality and cryptographic protection, in accordance with the data owner's requirements.

**Severity**: medium

**Description**:
Use of weak or untested encryption algorithms undermines the purposes of utilizing encryption to protect data. The application must implement cryptographic modules adhering to the higher standards approved by the federal government since this provides assurance they have been tested and validated.

It is the responsibility of the data owner to assess the cryptography requirements in light of applicable federal laws, Executive Orders, directives, policies, regulations, and standards.

For detailed information, refer to NIST FIPS Publication 140-2 or Publication 140-3, Security Requirements For Cryptographic Modules. Note that the product's cryptographic modules must be validated and certified by NIST as FIPS-compliant.

**Fix Text**:
```Implement NIST FIPS validated cryptographic modules to provision digital signatures\.

Turn on MySQL FIPS mode and restart mysqld
Edit my\.cnf
\[mysqld\]
ssl\_fips\_mode=ON

or
\[mysqld\]
ssl\_fips\_mode=STRICT

In general, STRICT imposes more restrictions than ON, but MySQL itself has no FIPS\-specific code other than to specify to OpenSSL the FIPS mode value\. The exact behavior of FIPS mode for ON or STRICT depends on the OpenSSL version\.```

**Check Text**:
```ALL cryptography is provided via OpenSSL and can be verified in FIPS mode. 

Run this command:
SELECT VARIABLE_NAME, VARIABLE_VALUE
FROM performance_schema.global_variables where variable_name = 'ssl_fips_mode';

If the VARIABLE_VALUE does not return "ON" or "STRICT", this is a finding.

In general, STRICT imposes more restrictions than ON, but MySQL itself has no FIPS-specific code other than to specify to OpenSSL the FIPS mode value. The exact behavior of FIPS mode for ON or STRICT depends on the OpenSSL version.```
