# V-235191 - The MySQL Database Server 8.0 must only accept end entity certificates issued by DoD PKI or DoD-approved PKI Certification Authorities (CAs) for the establishment of all encrypted sessions.

**Severity**: medium

**Description**:
Only DoD-approved external PKIs have been evaluated to ensure they have security controls and identity vetting procedures in place that are sufficient for DoD systems to rely on the identity asserted in the certificate. PKIs lacking sufficient security controls and identity vetting procedures risk being compromised and issuing certificates that enable adversaries to impersonate legitimate users. 

The authoritative list of DoD-approved PKIs is published at https://cyber.mil/pki-pke/interoperability.

This requirement focuses on communications protection for the DBMS session rather than for the network packet.

**Fix Text**:
```Remove any certificate that was not issued by a valid DoD certificate authority\.

Contact the organization's certificate issuer and request a new certificate that is issued by a valid DoD certificate authorities\.```

**Check Text**:
```To run MySQL in SSL mode, obtain a valid certificate signed by a single certificate authority. 

Before starting the MySQL database in SSL mode, verify the certificate used is issued by a valid DoD certificate authority.

Run this command:
openssl x509 -in <path_to_certificate_pem_file> -text | grep -i "issuer"

If there is any issuer present in the certificate that is not a DoD-approved certificate authority, this is a finding.```
