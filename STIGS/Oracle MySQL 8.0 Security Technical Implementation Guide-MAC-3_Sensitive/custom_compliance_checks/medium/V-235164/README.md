# V-235164 - The MySQL Database Server 8.0 software installation account must be restricted to authorized users.

**Severity**: medium

**Description**:
When dealing with change control issues, it must be noted any changes to the hardware, software, and/or firmware components of the information system and/or application can have significant effects on the overall security of the system. 

If the system were to allow any user to make changes to software libraries, those changes might be implemented without undergoing the appropriate testing and approvals that are part of a robust change management process.

Accordingly, only qualified and authorized individuals must be allowed access to information system components for purposes of initiating changes, including upgrades and modifications.

DBA and other privileged administrative or application owner accounts are granted privileges that allow actions that can have a great impact on database security and operation. It is especially important to grant privileged access to only those persons who are qualified and authorized to use them.

**Fix Text**:
```Develop, document, and implement procedures to restrict and track use of the MySQL Database Server 8\.0 software installation account\.```

**Check Text**:
```Review procedures for controlling and granting access to use of the DBMS software installation account.

If access or use of this account is not restricted to the minimum number of personnel required, or if unauthorized access to the account has been granted, this is a finding.```
