#!/usr/bin/env bash

# Load secrets from /run/secrets if the directory exists
function load_secrets () {
    set -a
    if [ -d "/run/secrets" ]; then
        for secret in /run/secrets/*; do
            declare -g "$(basename $secret)=$(cat $secret)"
        done
    fi
    set +a
}
