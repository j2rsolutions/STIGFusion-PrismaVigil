
#!/bin/bash
# STIG Name: apache_server_2.4_unix_server
# Finding ID: V-214267
# Severity: medium

# Check httpd.pid file permissions and ownership
httpd_pid_path=$(find / -name "httpd.pid" 2>/dev/null)
httpd_pid_permissions=$(stat -c %a "$httpd_pid_path")
httpd_pid_owner=$(stat -c %U "$httpd_pid_path")

if [[ $httpd_pid_permissions -ne 644 ]] || [[ $httpd_pid_owner != "root" ]]; then
  echo "httpd.pid file permissions or ownership is incorrect"
  exit 1
fi

# Check Apache service utilities permissions and ownership
service_path="/usr/sbin/service"
apachectl_path="/usr/sbin/apachectl"

service_permissions=$(stat -c %a "$service_path")
service_owner=$(stat -c %U "$service_path")

apachectl_permissions=$(stat -c %a "$apachectl_path")
apachectl_owner=$(stat -c %U "$apachectl_path")

if [[ $service_permissions -ne 755 ]] || [[ $service_owner != "root" ]] || [[ $apachectl_permissions -ne 755 ]] || [[ $apachectl_owner != "root" ]]; then
  echo "Apache service utilities permissions or ownership is incorrect"
  exit 1
fi

# If all checks pass
exit 0

