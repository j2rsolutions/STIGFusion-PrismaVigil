# V-214266 - The Apache web server must prohibit or restrict the use of nonsecure or unnecessary ports, protocols, modules, and/or services.

**Severity**: medium

**Description**:
Web servers provide numerous processes, features, and functionalities that use TCP/IP ports. Some of these processes may be deemed unnecessary or too unsecure to run on a production system.

The Apache web server must provide the capability to disable or deactivate network-related services that are deemed to be non-essential to the server mission, are too unsecure, or are prohibited by the Ports, Protocols, and Services Management (PPSM) Category Assurance List (CAL) and vulnerability assessments.

**Fix Text**:
Ensure the website enforces the use of IANA well-known ports for HTTP and HTTPS.

**Check Text**:```
Review the website to determine if HTTP and HTTPs are used in accordance with well known ports (e.g., 80 and 443) or those ports and services as registered and approved for use by the DoD PPSM. Any variation in PPS will be documented, registered, and approved by the PPSM. If not, this is a finding.
```