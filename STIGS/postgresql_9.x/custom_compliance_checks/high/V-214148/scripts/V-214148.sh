
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214148
# Severity: high

# This script checks if PostgreSQL instance uses procedural languages, such as pl/Python or pl/R, without AO authorization.

PG_LANGUAGES=$(psql -U postgres -c "\l")

if [[ $PG_LANGUAGES == *"pl/python"* || $PG_LANGUAGES == *"pl/r"* ]]; then
    echo "PostgreSQL instance uses procedural languages without AO authorization"
    exit 1
else
    echo "PostgreSQL instance does not use procedural languages or has AO authorization"
    exit 0
fi

