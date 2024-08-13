#!/usr/bin/env bash

source /usr/local/lib/shell/env.sh
source /usr/local/lib/shell/secrets.sh
source /usr/local/lib/shell/container_lifecycle.sh

# Save container defined variables to /.env.container
touch /.env.container
chown root:root /.env.container  # Root only
chmod 200 /.env.container        # Write only
save_environment > /.env.container
chmod 400 /.env.container        # Read only

# Load environment variables from /.env file
[ -f /.env ] && load_environment < /.env

# Load secrets from /run/secrets directory
load_secrets

# Load default values and expand environment
expand_environment

# Print information about the system
printf '==================================================\n'
printf '= %-46s =\n' ""
printf '= %-46s =\n' "USER: $USERNAME:$GROUPNAME ($USERID:$GROUPID)"
printf '= %-46s =\n' "HOST: $(hostname)"
printf '= %-46s =\n' "ADDRESS: $(hostname -I)"
printf '= %-46s =\n' "WORKDIR: $(pwd)"
printf '= %-46s =\n' "COMMAND: $@"
printf '= %-46s =\n' ""
printf '==================================================\n'

# Run startup scripts
function on_enter () {
    run_entrypoint_scripts
}

# Run cleanup scripts
function on_exit () {
    run_exitpoint_scripts
}

# Run on_exit when container is stopped, run on_enter now
trap "on_exit" EXIT
on_enter

# Run CMD
echo " ==> Running \"$@\" ... "
"$@"
