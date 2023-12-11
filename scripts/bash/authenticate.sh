#!/bin/bash

# Ask for the console hostname
read -p "Enter console hostname: " console_hostname

# Ask for the API version
read -p "Enter API version (e.g., 1, 2): " api_version

# Ask for the username
read -p "Enter username: " username

# Ask for the password (input will be hidden)
read -sp "Enter password: " password
echo

# Making the curl request
curl -k \
  -H "Content-Type: application/json" \
  -X POST \
  -d \
"{
   \"username\":\"$username\",
   \"password\":\"$password\"
}" \
  https://$console_hostname/api/v$api_version/authenticate
