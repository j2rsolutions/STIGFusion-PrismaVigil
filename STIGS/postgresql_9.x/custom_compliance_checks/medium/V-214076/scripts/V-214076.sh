
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214076
# Severity: medium

# Get the PostgreSQL library directory
pg_lib_dir=$(pg_config --libdir)

# List all directories in the PostgreSQL library directory
dirs_in_pg_lib_dir=$(ls -l $pg_lib_dir | grep '^d' | awk '{print $9}')

# Check each directory
for dir in $dirs_in_pg_lib_dir
do
    # If the directory is not a PostgreSQL directory, echo the finding and exit with 1
    if [[ $dir != "postgresql"* ]]; then
        echo "Non-PostgreSQL directory found in PostgreSQL library directory: $dir"
        exit 1
    fi
done

# If no non-PostgreSQL directories were found, exit with 0
exit 0

