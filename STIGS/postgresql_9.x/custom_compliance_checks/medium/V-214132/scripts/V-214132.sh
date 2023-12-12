
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214132
# Severity: medium

# Check log_line_prefix settings
log_line_prefix=$(sudo su - postgres -c "psql -t -c \"SHOW log_line_prefix\"")
if [[ ! $log_line_prefix == *"< %m %a %u %d %r %p >"* ]]; then
  echo "log_line_prefix setting is incorrect"
  exit 1
fi

# Check shared_preload_libraries settings
shared_preload_libraries=$(sudo su - postgres -c "psql -t -c \"SHOW shared_preload_libraries\"")
if [[ ! $shared_preload_libraries == *"pgaudit"* ]]; then
  echo "shared_preload_libraries setting is incorrect"
  exit 1
fi

exit 0

