#!/usr/bin/env bash

# This script will configure the guest system to match configuration of the host system
# This is necessary to avoid various conflicts in development environments

# Set the timezone
if [[ -n "${TZ}" ]]; then
    echo "[docker-entrypoint.d/00-linux.sh] Setting timezone to \"${TZ}\" ... "
    if [ ! -f /usr/share/zoneinfo/"$TZ" ]; then
        echo "[docker-entrypoint.d/00-linux.sh] Timezone \"$TZ\" does not exist! ... " >&2
        exit 1
    fi
    ln --force --logical --symbolic --no-target-directory /usr/share/zoneinfo/"$TZ" /etc/localtime
    echo "[docker-entrypoint.d/00-linux.sh] $TZ" > /etc/timezone
fi

# Set locale
if [[ -n "${LOCALE}" ]]; then
    echo "[docker-entrypoint.d/00-linux.sh] Setting locale to \"${LOCALE}\" ... "
    if ! grep --ignore-case "$LOCALE" /etc/locale.gen >/dev/null; then
        echo "[docker-entrypoint.d/00-linux.sh] Locale \"$LOCALE\" does not exist! ... " >&2
        exit 1
    fi
    echo "[docker-entrypoint.d/00-linux.sh] Generating locales ... "
    sed --in-place --regexp-extended "s|# ($LOCALE.+)|\1|g" /etc/locale.gen
    locale-gen
    echo "[docker-entrypoint.d/00-linux.sh] Changing default system locale to \"${LOCALE}\" ... "
    update-locale --reset LANG=en_GB.UTF-8
fi

# Create $USERNAME and $GROUPNAME with $USERID and $GROUPID
echo "[docker-entrypoint.d/00-linux.sh] Creating user & group $USERNAME:$GROUPNAME ($USERID:$GROUPID)"
if ! groupadd --gid "$GROUPID" "$GROUPNAME"; then
    echo "[docker-entrypoint.d/00-linux.sh] Failed to add group with GID $GROUPID and name $GROUPNAME ... " >&2
    exit 1
fi

# Assign additional groups to the $USERNAME
if [[ -n "$GROUPNAMES" ]]; then
    if ! useradd --create-home --comment "Docker User" --uid "$USERID" --gid "$GROUPID" --groups "$GROUPNAMES" --shell "$USERSHELL" "$USERNAME"; then
        echo "[docker-entrypoint.d/00-linux.sh] Failed to add user with UID $USERID, GID $GROUPID, GROUPS \"$GROUPNAMES\", and username $USERNAME ... " >&2
        exit 1
    fi
else
    if ! useradd --create-home --comment "Docker User" --uid "$USERID" --gid "$GROUPID" --shell "$USERSHELL" "$USERNAME"; then
        echo "[docker-entrypoint.d/00-linux.sh] Failed to add user with UID $USERID, GID $GROUPID, and username $USERNAME ... " >&2
        exit 1
    fi
fi
