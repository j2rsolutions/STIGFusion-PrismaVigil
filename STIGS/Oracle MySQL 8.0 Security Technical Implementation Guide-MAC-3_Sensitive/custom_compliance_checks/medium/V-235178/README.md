# V-235178 - The MySQL Database Server 8.0 must require users to reauthenticate when organization-defined circumstances or situations require reauthentication.

**Severity**: medium

**Description**:
The DoD standard for authentication of an interactive user is the presentation of a Common Access Card (CAC) or other physical token bearing a valid, current, DoD-issued Public Key Infrastructure (PKI) certificate, coupled with a Personal Identification Number (PIN) to be entered by the user at the beginning of each session and whenever reauthentication is required.

Without reauthentication, users may access resources or perform tasks for which they do not have authorization. 

When applications provide the capability to change security roles or escalate the functional capability of the application, it is critical the user reauthenticate.

In addition to the reauthentication requirements associated with session locks, organizations may require reauthentication of individuals and/or devices in other situations, including (but not limited to) the following circumstances:

(i) When authenticators change; 
(ii) When roles change; 
(iii) When security categories of information systems change; 
(iv) When the execution of privileged functions occurs; 
(v) After a fixed period of time; or
(vi) Periodically.

Within the DoD, the minimum circumstances requiring reauthentication are privilege escalation and role changes.

**Fix Text**:
```Modify and/or configure MySQL and related applications and tools so that users are always required to reauthenticate when changing role or escalating privileges\.

To make a single user reauthenticate, the following must be present:

KILL CONNECTION processslist\_id;```

**Check Text**:
```Determine all situations where a user must reauthenticate. Check if the mechanisms that handle such situations use the following SQL:

To make a single user reauthenticate, an existing connection must be present:

To search for a specific user:
SELECT * FROM information_schema.PROCESSLIST where user ='<name> and host like '%';

To review all  connections:
SELECT * FROM INFORMATION_SCHEMA.PROCESSLIST;

Note the ID(s) (processlist_id) of the connection(s) for the user that must reauthenticate.

To make a user reauthenticate, run the following for each ID returned above (as they can have multiple connections):

KILL CONNECTION processslist_id;

If the provided SQL does not force reauthentication, this is a finding.```
