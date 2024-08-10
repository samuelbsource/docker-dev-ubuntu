#!/usr/bin/env bash

# This script configures cron.

# Default values
export CRON_LOGLEVEL=${CRON_LOGLEVEL:-"15"} # see CRON(8), default: log everything

# Configure cron daemon
sed --in-place "s|{CRON_LOGLEVEL}|$CRON_LOGLEVEL|g" /etc/supervisor/conf.d/cron.conf
