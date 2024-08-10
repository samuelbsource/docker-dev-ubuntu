#!/usr/bin/env bash

# This script will configure the guest system to match configuration of the host system
# This is necessary to avoid various conflicts in development environments

# Default values
export TZ=${TZ:-"Europe/London"}
export LOCALE=${LOCALE:-"en_GB.UTF-8"}
export USERID=${USERID:-1000}
export GROUPID=${GROUPID:-1000}
export USERNAME=${USERNAME:-user}
export GROUPNAME=${GROUPNAME:-user}
export GROUPNAMES=${GROUPNAMES:-""}
export USERSHELL=${USERSHELL:-"/bin/bash"}


# Set the timezone
if [[ -n "${TZ}" ]]; then
    echo "Setting timezone to \"${TZ}\" ... "
    if [ ! -f /usr/share/zoneinfo/"$TZ" ]; then
        echo "Timezone \"$TZ\" does not exist! ... " >&2
        exit 1
    fi
    ln --force --logical --symbolic --no-target-directory /usr/share/zoneinfo/"$TZ" /etc/localtime
    echo "$TZ" > /etc/timezone
fi

# Set locale
if [[ -n "${LOCALE}" ]]; then
    echo "Setting locale to \"${LOCALE}\" ... "
    if ! grep --ignore-case "$LOCALE" /etc/locale.gen >/dev/null; then
        echo "Locale \"$LOCALE\" does not exist! ... " >&2
        exit 1
    fi
    echo "Generating locales ... "
    sed --in-place --regexp-extended "s|# ($LOCALE.+)|\1|g" /etc/locale.gen
    locale-gen
    echo "Changing default system locale to \"${LOCALE}\" ... "
    update-locale --reset LANG=en_GB.UTF-8
fi

# Create $USERNAME and $GROUPNAME with $USERID and $GROUPID
echo "Creating user & group $USERNAME:$GROUPNAME ($USERID:$GROUPID)"
if ! groupadd --gid "$GROUPID" "$GROUPNAME"; then
    echo "Failed to add group with GID $GROUPID and name $GROUPNAME ... " >&2
fi
if [[ -n "$GROUPNAMES" ]]; then
    if ! useradd --create-home --comment "Docker User" --uid "$USERID" --gid "$GROUPID" --groups "$GROUPNAMES" --shell "$USERSHELL" "$USERNAME"; then
        echo "Failed to add user with UID $USERID, GID $GROUPID, GROUPS \"$GROUPNAMES\", and username $USERNAME ... " >&2
    fi
else
    if ! useradd --create-home --comment "Docker User" --uid "$USERID" --gid "$GROUPID" --shell "$USERSHELL" "$USERNAME"; then
        echo "Failed to add user with UID $USERID, GID $GROUPID, and username $USERNAME ... " >&2
    fi
fi
