#!/usr/bin/env bash
set -e

alias install="install --verbose --owner=root --group=root"

# Create directories and set permissions
mkdir --parents /etc/{docker-entrypoint.d,docker-env.d,docker-reloadpoint.d,notify-files.d,notify.d,supervisor,supervisor/conf.d} /usr/local/{bin,lib/shell}
chown root:root /etc/{docker-entrypoint.d,docker-env.d,docker-reloadpoint.d,notify-files.d,notify.d,supervisor,supervisor/conf.d} /usr/local/{bin,lib/shell}

# Delete file to avoid conflict
rm --verbose --force /etc/supervisor/supervisord.conf

# Copy files into right locations and set right permissions
install --mode=700 /tmp/rootfs/docker-entrypoint.sh /docker-entrypoint.sh
install --mode=700 /tmp/rootfs/etc/docker-entrypoint.d/00-linux.sh /etc/docker-entrypoint.d/00-linux.sh
install --mode=700 /tmp/rootfs/etc/docker-entrypoint.d/01-supervisor.sh /etc/docker-entrypoint.d/01-supervisor.sh
install --mode=700 /tmp/rootfs/etc/docker-entrypoint.d/02-cron.sh /etc/docker-entrypoint.d/02-cron.sh
install --mode=700 /tmp/rootfs/etc/docker-entrypoint.d/03-notify.sh /etc/docker-entrypoint.d/03-notify.sh
install --mode=700 /tmp/rootfs/etc/docker-env.d/00-linux.sh /etc/docker-env.d/00-linux.sh
install --mode=700 /tmp/rootfs/etc/docker-env.d/01-supervisor.sh /etc/docker-env.d/01-supervisor.sh
install --mode=700 /tmp/rootfs/etc/docker-env.d/02-cron.sh /etc/docker-env.d/02-cron.sh
install --mode=700 /tmp/rootfs/etc/docker-env.d/03-notify.sh /etc/docker-env.d/03-notify.sh
install --mode=700 /tmp/rootfs/etc/docker-env.d/09-debugging.sh /etc/docker-env.d/09-debugging.sh
install --mode=700 /tmp/rootfs/etc/docker-reloadpoint.d/01-supervisor.sh /etc/docker-reloadpoint.d/01-supervisor.sh
install --mode=700 /tmp/rootfs/etc/docker-reloadpoint.d/02-cron.sh /etc/docker-reloadpoint.d/02-cron.sh
install --mode=700 /tmp/rootfs/etc/docker-reloadpoint.d/03-notify.sh /etc/docker-reloadpoint.d/03-notify.sh
install --mode=700 /tmp/rootfs/etc/notify-files.d/00-env.sh /etc/notify-files.d/00-env.sh
install --mode=700 /tmp/rootfs/etc/notify.d/00-env.sh /etc/notify.d/00-env.sh
install --mode=600 /tmp/rootfs/etc/supervisor/conf.d/cron.conf.env /etc/supervisor/conf.d/cron.conf.env
install --mode=600 /tmp/rootfs/etc/supervisor/conf.d/notify.conf.env /etc/supervisor/conf.d/notify.conf.env
install --mode=600 /tmp/rootfs/etc/supervisor/supervisord.conf.env /etc/supervisor/supervisord.conf.env
install --mode=755 /tmp/rootfs/usr/local/bin/notify.sh /usr/local/bin/notify.sh
install --mode=755 /tmp/rootfs/usr/local/lib/shell/boolean.sh /usr/local/lib/shell/boolean.sh
install --mode=755 /tmp/rootfs/usr/local/lib/shell/container_lifecycle.sh /usr/local/lib/shell/container_lifecycle.sh
install --mode=755 /tmp/rootfs/usr/local/lib/shell/env.sh /usr/local/lib/shell/env.sh
install --mode=755 /tmp/rootfs/usr/local/lib/shell/expand-from-env.sh /usr/local/lib/shell/expand-from-env.sh
install --mode=755 /tmp/rootfs/usr/local/lib/shell/secrets.sh /usr/local/lib/shell/secrets.sh
