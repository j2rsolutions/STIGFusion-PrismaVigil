
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214237
# Severity: medium

echo "Finding ID: V-214237"
echo "STIG Name: apache_server_2.4_unix_server"
echo "Severity: medium"
echo "Manual Check: Interview the Information System Security Officer, System Administrator, Web Manager, Webmaster, or developers as necessary to determine whether a tested and verifiable backup strategy has been implemented for web server software and all web server data files."
echo "Proposed questions:"
echo "- Who maintains the backup and recovery procedures?"
echo "- Do you have a copy of the backup and recovery procedures?"
echo "- Where is the off-site backup location?"
echo "- Is the contingency plan documented?"
echo "- When was the last time the contingency plan was tested?"
echo "- Are the test dates and results documented?"
echo "If there is not a backup and recovery process for the web server, this is a finding."

exit 0

