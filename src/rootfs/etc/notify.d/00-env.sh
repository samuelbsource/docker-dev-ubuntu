#!/usr/bin/env bash

if [[ "${LINE[0]}" == "/.env" ]]; then
    # If .env file changed, reload the environment and rebuild container.
    echo "[notify.d/00-env.sh] $(date '+%Y-%m-%d %H:%M:%S') A \"${LINE[1]}\" to \"${LINE[0]}\" was detected, reloading environment ... "

    # Clean the current environment variables
    clean_environment
    
    # Load environment variables from /.env.container file
    [ -f /.env.container ] && load_environment < /.env.container

    # Load environment variables from /.env file
    [ -f /.env ] && load_environment < /.env

    # Load secrets from /run/secrets directory
    load_secrets

    # Load default values and expand environment
    expand_environment

    # Reload container
    run_reloadpoint_scripts

    # reload supervisor
    /usr/bin/supervisorctl --configuration '/etc/supervisor/supervisord.conf' reread
    /usr/bin/supervisorctl --configuration '/etc/supervisor/supervisord.conf' update
fi
