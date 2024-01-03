# V-235195 - When invalid inputs are received, the MySQL Database Server 8.0 must behave in a predictable and documented manner that reflects organizational and system objectives.

**Severity**: medium

**Description**:
A common vulnerability is unplanned behavior when invalid inputs are received. This requirement guards against adverse or unintended system behavior caused by invalid inputs, where information system responses to the invalid input may be disruptive or cause the system to fail into an unsafe state.

The behavior will be derived from the organizational and system requirements and includes, but is not limited to, notification of the appropriate personnel, creating an audit record, and rejecting invalid input.

This calls for inspection of application source code, which will require collaboration with the application developers. It is recognized that in many cases, the database administrator (DBA) is organizationally separate from the application developers, and may have limited, if any, access to source code. Nevertheless, protections of this type are so important to the secure operation of databases that they must not be ignored. At a minimum, the DBA must attempt to obtain assurances from the development organization that this issue has been addressed, and must document what has been discovered.

**Fix Text**:
```Configure the MySQL Server to behave in a predictable and documented manner that reflects organizational and system objectives when invalid inputs are received\.

To validate data at the database table level modify tables by adding constraints CHECK constraint is a type of integrity constraint in SQL within the create or alter table statement\.

\[CONSTRAINT \[symbol\]\] CHECK \(expr\) \[\[NOT\] ENFORCED\]
For example
CREATE TABLE checker \(i tinyint, CONSTRAINT i\_must\_be\_between\_7\_and\_12 CHECK \(i BETWEEN 7 AND 12 \) \); 
Adding a constraint to an existing table 

ALTER TABLE <table\_name> 
           ADD \[CONSTRAINT \[symbol\]\] CHECK \(condition\) \[\[NOT\] ENFORCED\]```

**Check Text**:
```Review the MySQL Server to ensure it behaves in a predictable and documented manner that reflects organizational and system objectives when invalid inputs are received.

To determine if table check constraints that have been put in place:
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS;

If input validation is required beyond those enforced by the datatype and no constraints exist for data input, this is a finding.```
