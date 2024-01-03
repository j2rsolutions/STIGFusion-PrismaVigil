# V-235123 - The MySQL Database Server 8.0 must generate audit records when categories of information (e.g., classification levels/security levels) are deleted.

**Severity**: medium

**Description**:
Changes in categories of information must be tracked. Without an audit trail, unauthorized access to protected data could go undetected.

For detailed information on categorizing information, refer to FIPS Publication 199, Standards for Security Categorization of Federal Information and Information Systems, and FIPS Publication 200, Minimum Security Requirements for Federal Information and Information Systems.

**Fix Text**:
```Deploy a MySQL Database Server 8\.0 capable of producing the required audit records when categories of information are deleted\.

Configure the MySQL Database Server 8\.0 to produce audit records when categories of information are deleted\.```

**Check Text**:
```Review DBMS documentation to verify that audit records can be produced when categories of information are deleted.

If the DBMS is not capable of this, this is a finding.

Review the DBMS/database security and audit configurations to verify that audit records are produced when categories of information are deleted.

If they are not produced, this is a finding.```
