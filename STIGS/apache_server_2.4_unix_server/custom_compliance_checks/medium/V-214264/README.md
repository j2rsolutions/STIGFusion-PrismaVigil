# V-214264 - The Apache web server must be configured to integrate with an organizations security infrastructure.

**Severity**: medium

**Description**:
A web server will typically use logging mechanisms for maintaining a historical log of activity that occurs within a hosted application. This information can then be used for diagnostic purposes, forensics purposes, or other purposes relevant to ensuring the availability and integrity of the hosted application.

While it is important to log events identified as being critical and relevant to security, it is equally important to notify the appropriate personnel in a timely manner so they are able to respond to events as they occur. 

Manual review of the web server logs may not occur in a timely manner, and each event logged is open to interpretation by a reviewer. By integrating the web server into an overall or organization-wide log review, a larger picture of events can be viewed, and analysis can be done in a timely and reliable manner.

**Fix Text**:
 Work with the SIEM administrator to integrate with an organizations security infrastructure\.

**Check Text**:
Work with the SIEM administrator to determine current security integrations. 

If the SIEM is not integrated with security, this is a finding.
