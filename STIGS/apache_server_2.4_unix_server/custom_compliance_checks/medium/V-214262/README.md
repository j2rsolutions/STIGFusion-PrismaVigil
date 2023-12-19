# V-214262 - The Apache web server must use a logging mechanism that is configured to allocate log record storage capacity large enough to accommodate the logging requirements of the Apache web server.

**Severity**: medium

**Description**:
To make certain that the logging mechanism used by the web server has sufficient storage capacity in which to write the logs, the logging mechanism needs to be able to allocate log record storage capacity.

The task of allocating log record storage capacity is usually performed during initial installation of the logging mechanism. The System Administrator will usually coordinate the allocation of physical drive space with the Web Server Administrator along with the physical location of the partition and disk. Refer to NIST SP 800-92 for specific requirements on log rotation and storage dependent on the impact of the web server.

**Fix Text**:```
Work with the SIEM administrator to determine if the SIEM is configured to allocate log record storage capacity large enough to accommodate the logging requirements of the Apache web server.
```
**Check Text**:
Work with SIEM administrator to determine log storage capacity. 

If there is no setting within a SIEM to accommodate enough a large logging capacity, this is a finding.
