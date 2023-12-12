
#!/bin/bash
# STIG Name: postgresql_9.x
# Finding ID: V-214136
# Severity: high

# Switch to postgres user and get the file paths
ssl_ca_file=$(sudo -u postgres psql -c "SHOW ssl_ca_file" | sed -n 3p | xargs)
ssl_cert_file=$(sudo -u postgres psql -c "SHOW ssl_cert_file" | sed -n 3p | xargs)
ssl_crl_file=$(sudo -u postgres psql -c "SHOW ssl_crl_file" | sed -n 3p | xargs)
ssl_key_file=$(sudo -u postgres psql -c "SHOW ssl_key_file" | sed -n 3p | xargs)

# Check if the directories are protected
for file in $ssl_ca_file $ssl_cert_file $ssl_crl_file $ssl_key_file
do
    dir=$(dirname "$file")
    if [ $(stat -c %a "$dir") -ne 700 ]; then
        echo "Directory $dir is not protected"
        exit 1
    fi
done

# If all directories are protected, exit with 0
exit 0

