# V-235152 - Database contents must be protected from unauthorized and unintended information transfer by enforcement of a data-transfer policy.

**Severity**: medium

**Description**:
Applications, including DBMSs, must prevent unauthorized and unintended information transfer via shared system resources. 

Data used for the development and testing of applications often involves copying data from production. It is important that specific procedures exist for this process, to include the conditions under which such transfer may take place, where the copies may reside, and the rules for ensuring sensitive data are not exposed.

Copies of sensitive data must not be misplaced or left in a temporary location without the proper controls.

**Fix Text**:
```Modify any code used for moving data from production to development/test systems to comply with the organization\-defined data transfer policy, and to ensure copies of production data are not left in unsecured locations\.```

**Check Text**:
```Review the procedures for the refreshing of development/test data from production. Review any scripts or code that exists for the movement of production data to development/test systems, or to any other location or for any other purpose. Verify that copies of production data are not left in unprotected locations. 

If the code that exists for data movement does not comply with the organization-defined data transfer policy and/or fails to remove any copies of production data from unprotected locations, this is a finding.```
