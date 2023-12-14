

# STIG_Apache2.4_ServiceAccount_ShellAndPassword README

## Overview
The "STIG_Apache2.4_ServiceAccount_ShellAndPassword" rule is designed to monitor and alert on changes to the Apache service account's login shell or password status. It plays a critical role in maintaining the security and compliance of Apache 2.4 servers.

## Rule Description
- **Rule ID**: 58
- **Type**: Processes
- **Script**:
  
  proc.cmdline contains "passwd -u"

- **Implementation Notes**:
  The rule triggers an alert for attempts to modify the Apache service account's login shell or password settings.
  This is crucial for preventing unauthorized access using default or weak credentials.
  Integration with incident response systems for timely action is advisable.
  Regular audits and reviews are recommended to ensure effectiveness and compliance.
  
- **Description**: This rule is aimed at ensuring compliance with STIG Finding V-214271, which requires that the account running the Apache web server must not have a valid login shell and password. It focuses on detecting unauthorized modifications that could enable login capabilities to the Apache service account, a potential security risk.

- **Alert Message**: 
  
  Potential Compliance Deviation Detected: An action altering the login shell or password of the Apache service account was observed, potentially conflicting with STIG Finding V-214271. Immediate investigation is required.
  

## STIG Reference
This rule is related to the following STIG:

- [STIG apache_server_2.4_unix_server - Finding ID: V-214271](https://github.com/j2rsolutions/STIGFusion-PrismaVigil/tree/main/STIGS/apache_server_2.4_unix_server/custom_compliance_checks/high/V-214271)

## Additional Information
- **Owner**: jonathan
- **Modified**: 12/12/23, 15:48:52
- **Exported By**: jonathan
- **Min. Version**: [Specify if applicable]
- **Usage**: Apache Monitoring
- **Policy Type**: Custom Rules

