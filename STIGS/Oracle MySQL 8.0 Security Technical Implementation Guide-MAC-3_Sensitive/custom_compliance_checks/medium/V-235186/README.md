# V-235186 - The MySQL Database Server 8.0 must maintain the confidentiality and integrity of information during preparation for transmission.

**Severity**: medium

**Description**:
Information can be either unintentionally or maliciously disclosed or modified during preparation for transmission, including, for example, during aggregation, at protocol transformation points, and during packing/unpacking. These unauthorized disclosures or modifications compromise the confidentiality or integrity of the information.

Use of this requirement will be limited to situations where the data owner has a strict requirement for ensuring data integrity and confidentiality is maintained at every step of the data transfer and handling process. 

When transmitting data, the DBMS, associated applications, and infrastructure must leverage transmission protection mechanisms.

**Fix Text**:
```Turn on require\_secure\_transport\. In this mode the server permits only TCP/IP connections encrypted using TLS/SSL, or connections that use a socket file \(on UNIX\) or shared memory \(on Windows\)\. 

The server rejects nonsecure connection attempts, which fail with an ER\_SECURE\_TRANSPORT\_REQUIRED error\.

set persist require\_secure\_transport=ON;```

**Check Text**:
```If the data owner does not have a strict requirement for ensuring data integrity and confidentiality is maintained at every step of the data transfer and handling process, this is not a finding.

Run the following:
select @@require_secure_transport;

The value should be 1 (ON) versus 0 (OFF), if the value is 0 (OFF), this is a finding.```
