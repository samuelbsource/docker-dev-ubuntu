#!/usr/bin/env bash

source /usr/local/lib/shell/boolean.sh

export SUPERVISOR_GENERATE_RANDOM_CREDENTIALS=${SUPERVISOR_GENERATE_RANDOM_CREDENTIALS:-true}

# Generate random username and password for supervisor
if is_true "$SUPERVISOR_GENERATE_RANDOM_CREDENTIALS"; then
    echo "Generating random supervisor credentials ... "
    sed --in-place --regexp-extended "s|^(username)=.+;|\1=$(pwgen 32 1)  ;|g" /etc/supervisor/supervisord.conf
    sed --in-place --regexp-extended "s|^(password)=.+;|\1=$(pwgen 32 1)  ;|g" /etc/supervisor/supervisord.conf
fi
