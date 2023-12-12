
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214055
# Severity: medium

# Check if postgresql is installed
if ! command -v psql &> /dev/null
then
    echo "postgresql is not installed"
    exit 1
fi

# Check ownership and permissions of postgresql configuration files
PGDATA=$(sudo -u postgres psql -t -P format=unaligned -c 'show data_directory;')
OWNER=$(stat -c '%U' $PGDATA)
PERMISSIONS=$(stat -c '%a' $PGDATA)

if [[ $OWNER != "postgres" ]] || [[ $PERMISSIONS -gt 700 ]]
then
    echo "postgresql configuration files are not properly owned or have incorrect permissions"
    exit 1
fi

# Check ownership of postgresql objects
OBJECTS=$(sudo -u postgres psql -t -P format=unaligned -c "\df+")
IFS=$'\n'
for OBJECT in $OBJECTS
do
    OWNER=$(echo $OBJECT | awk '{print $1}')
    if [[ $OWNER != "postgres" ]]
    then
        echo "postgresql object $OBJECT is not owned by postgres"
        exit 1
    fi
done

echo "postgresql configuration files and objects are properly owned and have correct permissions"
exit 0

