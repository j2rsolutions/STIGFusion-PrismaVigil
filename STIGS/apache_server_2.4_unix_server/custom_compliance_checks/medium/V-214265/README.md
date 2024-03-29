# V-214265 - The Apache web server must generate log records that can be mapped to Coordinated Universal Time (UTC) or Greenwich Mean Time (GMT) which are stamped at a minimum granularity of one second.

**Severity**: medium

**Description**:
If time stamps are not consistently applied and there is no common time reference, it is difficult to perform forensic analysis across multiple devices and log records.

Time stamps generated by the Apache web server include date and time. Time is commonly expressed in UTC, a modern continuation of GMT, or local time with an offset from UTC.

Without sufficient granularity of time stamps, it is not possible to adequately determine the chronological order of records.

Time stamps generated by the Apache web server include date and time and must be to a granularity of one second.

Satisfies: SRG-APP-000374-WSR-000172, SRG-APP-000375-WSR-000171

**Fix Text**:
```In a command line, run "httpd \-M" to view a list of installed modules\.

If "log\_config\_module" is not listed, enable this module\.

Review the "httpd\.conf" file\.

Determine if the "LogFormat" directive exists\. If it does not exist, ensure the "LogFormat" line contains the %t flag\.```

**Check Text**:
```Review the web server documentation and configuration to determine the time stamp format for log data.

Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file:

# apachectl -V | egrep -i 'httpd_root|server_config_file'
-D HTTPD_ROOT="/etc/httpd"
-D SERVER_CONFIG_FILE="conf/httpd.conf"

Note: The apachectl front end is the preferred method for locating the Apache httpd file. For some Linux distributions, "apache2ctl -V" or  "httpd -V" can also be used.  

Search for the "log_config_module" directive:

# cat /<path_to_file>/httpd.conf | grep -i "LogFormat"

Verify the "LogFormat" directive exists.

If the "LogFormat" directive does not exist, this is a finding.

Verify the "LogFormat" line contains the "%t" flag.
 
If "%t" flag is not present, time is not mapped to UTC or GMT time, this is a finding.```
