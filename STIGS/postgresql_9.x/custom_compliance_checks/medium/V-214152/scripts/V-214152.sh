
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214152
# Severity: medium

# Check postgresql.conf file permissions
PG_CONF_PERMISSIONS=$(stat -c %a ${PGDATA?}/postgresql.conf)
PG_CONF_OWNER=$(stat -c %U ${PGDATA?}/postgresql.conf)

if [[ "$PG_CONF_PERMISSIONS" -ne 600 ]] || [[ "$PG_CONF_OWNER" != "postgres" ]]; then
  echo 'postgresql.conf file permissions check failed'
  exit 1
fi

# Check log file permissions
LOG_FILE_MODE=$(sudo -u postgres psql -c "SHOW log_file_mode" | awk 'NR==3 {print $1}')

if [[ "$LOG_FILE_MODE" != "600" ]]; then
  echo 'Log file permissions check failed'
  exit 1
fi

# Check syslog file permissions if PostgreSQL is configured to use syslog
SYSLOG_CONF=$(sudo -u postgres psql -c "SHOW syslog_ident" | awk 'NR==3 {print $1}')

if [[ "$SYSLOG_CONF" != "" ]]; then
  SYSLOG_FILE_PERMISSIONS=$(stat -c %a /var/log/syslog)
  SYSLOG_FILE_OWNER=$(stat -c %U /var/log/syslog)

  if [[ "$SYSLOG_FILE_PERMISSIONS" -ne 600 ]] || [[ "$SYSLOG_FILE_OWNER" != "root" ]]; then
    echo 'Syslog file permissions check failed'
    exit 1
  fi
fi

exit 0

