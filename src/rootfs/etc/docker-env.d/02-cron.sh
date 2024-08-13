#!/usr/bin/env bash

# Default values
export CRON_LOGLEVEL=${CRON_LOGLEVEL:-"15"}   # see CRON(8), default: log everything
export CRON_AUTOSTART=${CRON_AUTOSTART:-false}   # true = start cron on container start, false = don't start cron
