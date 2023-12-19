# V-214240 - The Apache web server must only contain services and functions necessary for operation.

**Severity**: medium

**Description**:
A web server can provide many features, services, and processes. Some of these may be deemed unnecessary or too unsecure to run on a production DoD system.

The web server must provide the capability to disable, uninstall, or deactivate functionality and services that are deemed to be non-essential to the web server mission or can adversely impact server performance.

**Fix Text**:
Remove any unnecessary applications per ISSO documentation.  

**Check Text**:```
If the site requires the use of a particular piece of software, verify that the Information System Security Officer (ISSO) maintains documentation identifying this software as necessary for operations. The software must be operated at the vendor’s current patch level and must be a supported vendor release.

If programs or utilities that meet the above criteria are installed on the web server and appropriate documentation and signatures are in evidence, this is not a finding.

Determine whether the web server is configured with unnecessary software.

Determine whether processes other than those that support the web server are loaded and/or run on the web server.

Examples of software that should not be on the web server are all web development tools, office suites (unless the web server is a private web development server), compilers, and other utilities that are not part of the web server suite or the basic operating system.

Check the directory structure of the server and verify that additional, unintended, or unneeded applications are not loaded on the system.

If, after review of the application on the system, there is no justification for the identified software, this is a finding. 

```