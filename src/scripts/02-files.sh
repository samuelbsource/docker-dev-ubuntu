#!/usr/bin/env bash

# Create directories
mkdir -p /etc/docker-entrypoint.d /etc/docker-exitpoint.d
chown root:root /etc/docker-entrypoint.d /etc/docker-exitpoint.d

# Copy files into right locations and set right permissions
install --mode=700 /tmp/rootfs/docker-entrypoint.sh /docker-entrypoint.sh
install --mode=700 /tmp/rootfs/etc/docker-entrypoint.d/00-linux.sh /etc/docker-entrypoint.d/00-linux.sh
install --mode=700 /tmp/rootfs/etc/docker-entrypoint.d/01-supervisor.sh /etc/docker-entrypoint.d/01-supervisor.sh
install --mode=700 /tmp/rootfs/etc/docker-entrypoint.d/02-cron.sh /etc/docker-entrypoint.d/02-cron.sh
install -D --mode=600 /tmp/rootfs/etc/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
install -D --mode=600 /tmp/rootfs/etc/supervisor/conf.d/cron.conf /etc/supervisor/conf.d/cron.conf
install -D --mode=755 /tmp/rootfs/usr/local/lib/shell/boolean.sh /usr/local/lib/shell/boolean.sh
install -D --mode=755 /tmp/rootfs/usr/local/lib/shell/expand-from-env.sh /usr/local/lib/shell/expand-from-env.sh
