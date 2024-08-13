#!/usr/bin/env bash

# Default values
export SUPERVISOR_USERNAME="${SUPERVISOR_USERNAME:-$(pwgen 32 1)}"   # Supervisor username, random by default
export SUPERVISOR_PASSWORD="${SUPERVISOR_PASSWORD:-$(pwgen 32 1)}"   # Supervisor password, random by default

# Save username and password, or load the value from the existing file.
# This ensures username and password can survive environment reload.
if [ ! -f "/root/.supervisor_username" ]; then
    touch /root/.supervisor_username
    chown root:root /root/.supervisor_username  # Root only
    chmod 200 /root/.supervisor_username        # Write only
    printf "%s" "$SUPERVISOR_USERNAME" > /root/.supervisor_username
    chmod 400 /root/.supervisor_username        # Read only
else
    SUPERVISOR_USERNAME="$(cat /root/.supervisor_username)"
fi

if [ ! -f "/root/.supervisor_password" ]; then
    touch /root/.supervisor_password
    chown root:root /root/.supervisor_password  # Root only
    chmod 200 /root/.supervisor_password        # Write only
    printf "%s" "$SUPERVISOR_PASSWORD" > /root/.supervisor_password
    chmod 400 /root/.supervisor_password        # Read only
else
    SUPERVISOR_PASSWORD="$(cat /root/.supervisor_password)"
fi
