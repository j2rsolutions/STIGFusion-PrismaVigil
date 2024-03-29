# V-235172 - The MySQL Database Server 8.0 must provide centralized configuration of the content to be captured in audit records generated by all components of the MySQL Database Server 8.0.

**Severity**: medium

**Description**:
If the configuration of the Database Management System's (DBMS's) auditing is spread across multiple locations in the database management software, or across multiple commands, only loosely related, it is harder to use and takes longer to reconfigure in response to events.

The DBMS must provide a unified tool for audit configuration.

**Fix Text**:
```Configure and/or deploy software tools to ensure that MySQL Server audit records are written directly to or systematically transferred to a centralized log management system\.```

**Check Text**:
```Review the system documentation for a description of how audit records are off-loaded and how local audit log space is managed. 

If the MySQL Server audit records are not written directly to or systematically transferred to a centralized log management system, this is a finding.```
