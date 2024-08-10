#!/usr/bin/env bash

# Load environment variables from /.env file
set -a
[ -f /.env ] && . /.env
set +a

# Load secrets from /run/secrets directory
if [ -d "/run/secrets" ]; then
    for secret in /run/secrets/*; do
        export $(basename $secret)=$(cat $secret)
    done
fi

# Default values
USERID=${USERID:-1000}
GROUPID=${GROUPID:-1000}
USERNAME=${USERNAME:-user}
GROUPNAME=${GROUPNAME:-user}

# Print information about the system
printf '==================================================\n'
printf '= %-46s =\n' ""
printf '= %-46s =\n' "USER: $USERNAME:$GROUPNAME ($USERID:$GROUPID)"
printf '= %-46s =\n' "HOST: $(hostname)"
printf '= %-46s =\n' "ADDRESS: $(hostname -I)"
printf '= %-46s =\n' "COMMAND: $@"
printf '= %-46s =\n' ""
printf '==================================================\n'

# Run startup scripts
function on_enter () {
    for script in /etc/docker-entrypoint.d/*.sh; do
        if [ -f "$script" ]; then
            echo " ==> Running \"${script}\" ... "
            . "$script"
        fi
    done
}

# Run cleanup scripts
function on_exit () {
    for script in /etc/docker-exitpoint.d/*.sh; do
        if [ -f "$script" ]; then
            echo " ==> Running \"${script}\" ... "
            . "$script"
        fi
    done
}

# Run on_exit when container is stopped, run on_enter now
trap "on_exit" EXIT
on_enter

# Run CMD
echo " ==> Running \"$@\" ... "
"$@"
