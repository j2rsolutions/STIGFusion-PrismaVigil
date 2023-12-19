python prismavigial.py -cr2j \
"STIG_Apache2.4_processes_VerifyPrivilegedAccountsAndScriptAccess" \
./rule \
"This rule monitors Apache 2.4 environments to ensure compliance with STIG requirements regarding privileged user accounts and access to shell scripts and OS functions. It logs instances of privileged account creation/modification and flags unauthorized script or system function access. Alerts are generated for undocumented accounts and unauthorized accesses, aiding in audit and review processes by SAs and ISSOs for ongoing STIG compliance. Finding ID: V-214248." \
"%proc.user% attempted to launch httpd. Unauthorized Access Detected in Critical Apache Directory. Access attempt outside allowed user list in compliance with STIG apache_server_2.4_unix_server, Finding ID: V-214248. Immediate investigation recommended." \
"jonathan" "1.0" "customRules" "exploitationForPrivilegeEscalation"
