#!/usr/bin/env bash
set -e

export LC_ALL="C.UTF-8"
export DEBIAN_FRONTEND="noninteractive"

# Set system language
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# update and install packages
apt-get update
apt-get upgrade -y
apt-get install -y $PACKER_ENV_PACKAGES

# Generate language files
locale-gen

# remove unnecesary cron jobs
rm -rf /etc/cron.d/e2scrub_all
