
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214078
# Severity: medium

# Check if postgresql is installed
if ! command -v psql &> /dev/null
then
    echo "postgresql is not installed"
    exit 1
fi

# Check for SECURITY DEFINER functions
SECURITY_DEFINER_FUNCTIONS=$(sudo -u postgres psql -c "SELECT nspname, proname, proargtypes, prosecdef, rolname, proconfig FROM pg_proc p JOIN pg_namespace n ON p.pronamespace = n.oid JOIN pg_authid a ON a.oid = p.proowner WHERE prosecdef OR NOT proconfig IS NULL")

if [[ -z "$SECURITY_DEFINER_FUNCTIONS" ]]; then
    echo "No SECURITY DEFINER functions found"
    exit 0
else
    echo "SECURITY DEFINER functions found"
    echo "$SECURITY_DEFINER_FUNCTIONS"
    exit 1
fi

