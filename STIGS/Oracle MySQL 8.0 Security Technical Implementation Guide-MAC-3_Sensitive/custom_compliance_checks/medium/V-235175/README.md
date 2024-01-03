# V-235175 - The MySQL Database Server 8.0 must provide a warning to appropriate support staff when allocated audit record storage volume reaches 75 percent of maximum audit record storage capacity.

**Severity**: medium

**Description**:
Organizations are required to use a central log management system, so, under normal conditions, the audit space allocated to the DBMS on its own server will not be an issue. However, space will still be required on the Database Management System's (DBMS) server for audit records in transit, and, under abnormal conditions, this could fill up. Since a requirement exists to halt processing upon audit failure, a service outage would result.

If support personnel are not notified immediately upon storage volume utilization reaching 75 percent, they are unable to plan for storage capacity expansion. 

The appropriate support staff include, at a minimum, the Information System Security Officer (ISSO) and the database administrator (DBA)/system administrator (SA).

**Fix Text**:
```Modify OS, or third\-party logging application settings to alert appropriate personnel when 75 percent of audit log storage capacity is reached\.```

**Check Text**:
```Review OS, or third-party logging application settings to determine whether a warning will be provided when 75 percent of DBMS audit log storage capacity is reached.

If no warning will be provided, this is a finding.```
