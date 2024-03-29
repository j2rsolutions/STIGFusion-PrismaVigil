# V-214260 - The Apache web server must be configured to immediately disconnect or disable remote access to the hosted applications.

**Severity**: medium

**Description**:
During an attack on the Apache web server or any of the hosted applications, the System Administrator (SA) may need to disconnect or disable access by users to stop the attack.

The Apache web server must be configured to disconnect users from a hosted application without compromising other hosted applications unless deemed necessary to stop the attack. Methods to disconnect or disable connections are to stop the application service for a specified hosted application, stop the Apache web server, or block all connections through the Apache web server access list.

The Apache web server capabilities used to disconnect or disable users from connecting to hosted applications and the Apache web server must be documented to make certain that, during an attack, the proper action is taken to conserve connectivity to any other hosted application if possible and to make certain log data is conserved for later forensic analysis.

**Fix Text**:
```Prepare documented procedures for shutting down an Apache website in the event of an attack\.

The procedure should, at a minimum, provide the following steps:

Search for the PidFile runtime directive\. \(This example uses the combined results of HTTPD\_ROOT and SERVER\_CONFIG\_FILE, above\.\) If this command returns a result, use this value in the kill command, otherwise, use the DEFAULT\_PIDLOG value, above\.

In a command line, enter the following command:

\# grep \-i pidfile /etc/httpd/conf/httpd\.conf  

\# kill \-TERM 'cat <FULLY\-QUALIFIED\_PIDFILE\_FILENAME>'
```

**Check Text**:
```Interview the SA and Web Manager.

Ask for documentation for the Apache web server administration.

Verify there are documented procedures for shutting down an Apache website in the event of an attack. 

The procedure must, at a minimum, provide the following steps:

1. Determine the respective website for the application at risk of an attack.

2. Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file:

# apachectl -V | egrep -i 'httpd_root|server_config_file|pidlog'
-D HTTPD_ROOT="/etc/httpd"
-D SERVER_CONFIG_FILE="conf/httpd.conf"
-D DEFAULT_PIDLOG=”/run/httpd/httpd.pid”
 
3. Search for the PidFile runtime directive. (This example uses the combined results of HTTPD_ROOT and SERVER_CONFIG_FILE, above.) 

# grep -i pidfile /etc/httpd/conf/httpd.conf  

4. If this command returns a result, use this value in the kill command, otherwise, use the DEFAULT_PIDLOG value, above.

# kill -TERM `cat <FULLY-QUALIFIED_PIDFILE_FILENAME>`
Note: These should be documented steps, validators should not run kill commands while reviewing production systems.

If the web server is not capable of or cannot be configured to disconnect or disable remote access to the hosted applications when necessary, this is a finding.```
