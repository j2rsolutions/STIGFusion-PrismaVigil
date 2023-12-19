# V-214254 - The Apache web server must be built to fail to a known safe state if system initialization fails, shutdown fails, or aborts fail.

**Severity**: medium

**Description**:
Determining a safe state for failure and weighing that against a potential denial of service for users depends on what type of application the web server is hosting. For an application presenting publicly available information that is not critical, a safe state for failure might be to shut down for any type of failure, but for an application that presents critical and timely information, a shutdown might not be the best state for all failures.

Performing a proper risk analysis of the hosted applications and configuring the web server according to what actions to take for each failure condition will provide a known fail safe state for the web server.

Satisfies: SRG-APP-000225-WSR-000140, SRG-APP-000225-WSR-000074

**Fix Text**:
Prepare documentation for disaster recovery methods for the Apache 2.4 web server in the event of the necessity for rollback.

Document and test the disaster recovery methods designed.

**Check Text**:
Interview the System Administrator for the Apache 2.4 web server.

Ask for documentation on the disaster recovery methods tested and planned for the Apache 2.4 web server in the event of the necessity for rollback.

If documentation for a disaster recovery has not been established, this is a finding.
