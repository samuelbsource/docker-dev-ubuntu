#!/usr/bin/env bash

source /usr/local/lib/shell/env.sh
source /usr/local/lib/shell/secrets.sh
source /usr/local/lib/shell/container_lifecycle.sh
source /usr/local/lib/shell/expand-from-env.sh

# Function for reloading list of files to watch
FILES=()
function load_files () {
    for script in /etc/notify-files.d/*.sh; do
        if [ -f "$script" ]; then
            FILES+=($(. "$script"))
        fi
    done

    if [[ -z "${FILES[@]}" ]]; then
        echo "[notify.sh] $(date '+%Y-%m-%d %H:%M:%S' ) Nothing to watch, exiting ... "
        exit 0
    fi
}

# Initial load
load_files

# Running in a loop because --monitor seems to duplicate events
echo "[notify.sh] $(date '+%Y-%m-%d %H:%M:%S' ) Setting up watches ... "
while true; do
    CMD="/usr/bin/inotifywait --no-dereference --timeout 0 --event modify --event attrib --event delete_self --event move_self ${FILES[@]}"

    # run the command and capture result, ignoring stderr
    LINE=($($CMD 2>/dev/null))

    # handle changes
    for script in /etc/notify.d/*.sh; do
        if [ -f "$script" ]; then
            . "$script"
        fi
    done

    # reload files
    load_files
done
