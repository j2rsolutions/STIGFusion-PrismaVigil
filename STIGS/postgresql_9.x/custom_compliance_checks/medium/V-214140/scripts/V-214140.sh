
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214140
# Severity: medium

# Check if postgresql is installed
if ! command -v psql &> /dev/null
then
    echo "postgresql is not installed"
    exit 1
fi

# Check tcp_keepalives_idle
idle=$(sudo -u postgres psql -c "SHOW tcp_keepalives_idle;" | grep -v "tcp_keepalives_idle" | xargs)
if [ -z "$idle" ]; then
    echo "tcp_keepalives_idle is not set"
    exit 1
fi

# Check tcp_keepalives_interval
interval=$(sudo -u postgres psql -c "SHOW tcp_keepalives_interval;" | grep -v "tcp_keepalives_interval" | xargs)
if [ -z "$interval" ]; then
    echo "tcp_keepalives_interval is not set"
    exit 1
fi

# Check tcp_keepalives_count
count=$(sudo -u postgres psql -c "SHOW tcp_keepalives_count;" | grep -v "tcp_keepalives_count" | xargs)
if [ -z "$count" ]; then
    echo "tcp_keepalives_count is not set"
    exit 1
fi

# Check statement_timeout
timeout=$(sudo -u postgres psql -c "SHOW statement_timeout;" | grep -v "statement_timeout" | xargs)
if [ -z "$timeout" ]; then
    echo "statement_timeout is not set"
    exit 1
fi

# If all checks pass
echo "All checks passed"
exit 0

