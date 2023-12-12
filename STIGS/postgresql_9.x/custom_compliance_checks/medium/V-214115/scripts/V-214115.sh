
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214115
# Severity: medium

# Check if log_line_prefix contains %m
log_line_prefix=$(sudo -u postgres psql -c "SHOW log_line_prefix" | grep '%m')

if [[ -z "$log_line_prefix" ]]; then
  echo "log_line_prefix does not contain %m"
  exit 1
fi

# Check if time stamps are being logged
latest_log=$(ls -Art /var/lib/pgsql/9.6/data/pg_log/ | tail -n 1)
time_stamp=$(sudo -u postgres cat /var/lib/pgsql/9.6/data/pg_log/$latest_log | grep -Eo '[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}')

if [[ -z "$time_stamp" ]]; then
  echo "Time stamps are not being logged"
  exit 1
fi

exit 0

