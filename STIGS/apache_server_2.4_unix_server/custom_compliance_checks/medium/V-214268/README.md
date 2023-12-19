# V-214268 - Cookies exchanged between the Apache web server and the client, such as session cookies, must have cookie properties set to prohibit client-side scripts from reading the cookie data.

**Severity**: medium

**Description**:
A cookie can be read by client-side scripts easily if cookie properties are not set properly. By allowing cookies to be read by the client-side scripts, information such as session identifiers could be compromised and used by an attacker who intercepts the cookie. Setting cookie properties (i.e., HttpOnly property) to disallow client-side scripts from reading cookies better protects the information inside the cookie.

Satisfies: SRG-APP-000439-WSR-000154, SRG-APP-000439-WSR-000155

**Fix Text**:
 Determine the location of the "HTTPD\_ROOT" directory and the "httpd\.conf" file:

\# apachectl \-V \| egrep \-i 'httpd\_root\|server\_config\_file'
\-D HTTPD\_ROOT="/etc/httpd"
\-D SERVER\_CONFIG\_FILE="conf/httpd\.conf"
 
NOTE: SSL directives may also be located in /etc/httpd/conf\.d/ssl\.conf\.

Set "Session" to "on"\.

Ensure the "SessionCookieName" directive includes "httpOnly" and "secure"\.

**Check Text**:
Verify the session cookie module is loaded

# httpd -M | grep -i session_cookie_module
Output should look similar to: session_cookie_module (shared)

Determine the location of the "HTTPD_ROOT" directory and the "httpd.conf" file:

# apachectl -V | egrep -i 'httpd_root|server_config_file'
-D HTTPD_ROOT="/etc/httpd"
-D SERVER_CONFIG_FILE="conf/httpd.conf"

Note: The apachectl front end is the preferred method for locating the Apache httpd file. For some Linux distributions, "apache2ctl -V" or  "httpd -V" can also be used. 

Search for the directive "Session" in the "httpd.conf" file:

# cat httpd.conf  | grep -i "Session"
Output should be similar to: 
Session on
SessionCookieName httpOnly Secure
SessionCryptoCipher aes256
SessionMaxAge 600

Note: SSL directives can also be located in /etc/httpd/conf.d/ssl.conf.

If the "Session" and "SessionCookieName" directives are not present, this is a finding.

If "Session" is not set to "on" and "SessionCookieName" does not contain "httpOnly" and "secure", this is a finding.
