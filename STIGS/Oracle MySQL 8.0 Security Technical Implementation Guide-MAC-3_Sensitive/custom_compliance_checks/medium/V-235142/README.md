# V-235142 - The MySQL Database Server 8.0 must be configured in accordance with the security configuration settings based on DoD security configuration and implementation guidance, including STIGs, NSA configuration guides, CTOs, DTMs, and IAVMs.

**Severity**: medium

**Description**:
Configuring the Database Management System (DBMS) to implement organization-wide security implementation guides and security checklists ensures compliance with federal standards and establishes a common security baseline across DoD that reflects the most restrictive security posture consistent with operational requirements. 

In addition to this SRG, sources of guidance on security and information assurance exist. These include NSA configuration guides, CTOs, DTMs, and IAVMs. The DBMS must be configured in compliance with guidance from all such relevant sources.

**Fix Text**:
```Configure MySQL in accordance with security configuration settings by reviewing the Operation System and MySQL documentation and applying the necessary configuration parameters to meet the configurations required by the STIG, NSA configuration guidelines, CTOs, DTMs, and IAVMs\.```

**Check Text**:
```Review the MySQL documentation and configuration to determine it is configured in accordance with DoD security configuration and implementation guidance, including STIGs, NSA configuration guides, CTOs, DTMs, and IAVMs.

If the MySQL is not configured in accordance with security configuration settings, this is a finding.```
