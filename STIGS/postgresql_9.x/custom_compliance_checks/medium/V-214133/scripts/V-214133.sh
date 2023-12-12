
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214133
# Severity: medium

# Check if the monitoring tool is installed and running
if ! pgrep -x "monitoring_tool" > /dev/null
then
    echo "V-214133: No script/tool is monitoring the partition for the PostgreSQL log directories"
    exit 1
fi

# Check if the partition utilization is more than 75%
if df /var/lib/postgresql/9.x/main/pg_log | awk '{ print $5}' | sed -n 2p | cut -d'%' -f1 - > 75
then
    echo "V-214133: Storage volume utilization has reached 75%, notify the support staff immediately"
    exit 1
fi

exit 0

