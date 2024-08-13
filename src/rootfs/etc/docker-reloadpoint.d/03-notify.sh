#!/usr/bin/env bash

source /usr/local/lib/shell/expand-from-env.sh

# Configure notify daemon
expand_from_env "/etc/supervisor/conf.d/notify.conf.env"
