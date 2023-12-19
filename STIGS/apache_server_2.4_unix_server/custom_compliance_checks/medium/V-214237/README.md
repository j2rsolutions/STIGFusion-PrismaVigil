# V-214237 - The log data and records from the Apache web server must be backed up onto a different system or media.

**Severity**: medium

**Description**:
Protection of log data includes ensuring log data is not accidentally lost or deleted. Backing up log records to an unrelated system or onto separate media than the system the web server is actually running on helps to ensure that, in the event of a catastrophic system failure, the log records will be retained.

**Fix Text**:
 Document the web server backup procedures\.

**Check Text**:
Interview the Information System Security Officer, System Administrator, Web Manager, Webmaster, or developers as necessary to determine whether a tested and verifiable backup strategy has been implemented for web server software and all web server data files.

Proposed questions:
- Who maintains the backup and recovery procedures?
- Do you have a copy of the backup and recovery procedures?
- Where is the off-site backup location?
- Is the contingency plan documented?
- When was the last time the contingency plan was tested?
- Are the test dates and results documented?

If there is not a backup and recovery process for the web server, this is a finding.
