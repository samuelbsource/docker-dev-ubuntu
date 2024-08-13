#!/usr/bin/env bash

source /usr/local/lib/shell/expand-from-env.sh

# Configure supervisor
expand_from_env "/etc/supervisor/supervisord.conf.env"
