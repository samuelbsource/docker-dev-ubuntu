#!/usr/bin/env bash

# Default values
export TZ=${TZ:-"Europe/London"}            # Set the container timezone, might also be used to set timezone of containers services, like PHP
export LOCALE=${LOCALE:-"en_GB.UTF-8"}      # Set container locale
export USERID=${USERID:-1000}               # Set user ID, if your host user id is not 1000, you can set this value to match your host user id to avoid permission issues
export GROUPID=${GROUPID:-1000}             # Set group ID, as above but for the user group
export USERNAME=${USERNAME:-user}           # Services inside the container will run as this username, probably don't need to change that, but you can set this value to your host username.
export GROUPNAME=${GROUPNAME:-user}         # As above
export GROUPNAMES=${GROUPNAMES:-""}         # Additional groups assigned to the service user
export USERSHELL=${USERSHELL:-"/bin/bash"}  # Default shell assigned to the service user
