#!/usr/bin/env bash

# Print environment variables defined for this docker container
# You can redirect the output to a file, and later load this file back with load_environment method
function save_environment () {
    env
}

# Load environment variables from stdin
function load_environment () {
    set -a
    while read -a LINE; do
        # Skip comments (start with #)
        if [[ "${LINE[@]}" == "#"* ]]; then
            continue
        fi

        local whole_line="${LINE[@]}"
        local var_name="${whole_line%%=*}"
        local var_value="${whole_line#*=}"
        var_name="${var_name##\ }"
        var_name="${var_name%%\ }"
        var_value="${var_value##\ }"
        var_value="${var_value%%\ }"
        var_value="${var_value##\"}"
        var_value="${var_value%%\"}"

        if [ "$var_name" == "" ] ||
        [ "$var_name" == "_" ] ||
        [ "$var_name" == "PWD" ] ||
        [ "$var_name" == "LS_COLORS" ] ||
        [ "$var_name" == "TERM" ]; then
            continue
        fi

        declare -g "${var_name}=${var_value}"
    done
    set +a
}

# Clean the current environment variables
function clean_environment () {
    for line in $(env); do
        local var_name="${line%%=*}"
        local var_value="${line#*=}"

        if [ "$var_name" == "_" ] ||
        [ "$var_name" == "PWD" ] ||
        [ "$var_name" == "LS_COLORS" ] ||
        [ "$var_name" == "TERM" ]; then
            continue
        fi

        unset "$var_name"
    done
}

# Expand environment using scripts from the /etc/docker-env.d directory
function expand_environment () {
    for script in /etc/docker-env.d/*.sh; do
        if [ -f "$script" ]; then
            echo " ==> Running \"${script}\" ... "
            . "$script"
        fi
    done
}
