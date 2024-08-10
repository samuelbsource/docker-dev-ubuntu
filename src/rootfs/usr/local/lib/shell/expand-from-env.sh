#!/usr/bin/env bash

source /usr/local/lib/shell/boolean.sh
export EXPAND_FROM_ENV_DEBUG_VALUES=${EXPAND_FROM_ENV_DEBUG_VALUES:-false}

# Function for expanding config files from .env files
function expand_from_env () {
    local filename="$1"
    local sed_pattern=""

    # Generate SED pattern for replacing values
    for item in $(grep --ignore-case --color=never --only-matching "{{ENV_.*}}" "$filename" | uniq --unique); do
        local var_name="${item:6:-2}" # remove {{ENV_*}} from the value
        sed_pattern="$sed_pattern;s|$item|${!var_name}|g"

        # Dump values to stdout for debugging
        if is_true "$EXPAND_FROM_ENV_DEBUG_VALUES"; then
            echo "[expand-from-env.sh]   - $item=${!var_name}"
        fi
    done

    # Substitute values or copy the file
    if [[ -n "$sed_pattern" ]]; then
        sed "${sed_pattern:1}" <"$filename" >"${filename%%\.env}" # Substitute values with sed and place in the $filename without the '.env' extension
        echo "'$filename' -> '${filename%%\.env}'"
    else
        echo "[expand-from-env.sh] Nothing to substitute in $filename file, copying ... "
        cp -v "$filename" "${filename%%\.env}"
    fi
}
