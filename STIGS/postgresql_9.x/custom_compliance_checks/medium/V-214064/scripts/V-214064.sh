
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214064
# Severity: medium

# This script checks for dynamic code execution in PostgreSQL source code and application source code.
# If dynamic code execution is found where static execution with strongly typed parameters could be used, the script will exit with 1.

# Please replace "/path/to/source" with the actual path to your PostgreSQL and application source code.

SOURCE_CODE_PATH="/path/to/source"

if grep -r -E "EXECUTE format\(|EXECUTE\(" $SOURCE_CODE_PATH; then
    echo "Dynamic code execution found"
    exit 1
else
    echo "No dynamic code execution found"
    exit 0
fi

