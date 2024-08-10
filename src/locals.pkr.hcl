locals {
  image_entrypoint = "/docker-entrypoint.sh"
  image_default_command = ["/usr/bin/supervisord", "--nodaemon", "--configuration", "/etc/supervisor/supervisord.conf"]
  authors = [
    "Samuel Boczek <samuelboczek@gmail.com>"
  ]
  source = "https://github.com/samuelbsource/docker-dev-ubuntu"
  packages = [
    "software-properties-common",
    "apt-transport-https",
    "apt-utils",
    "debconf-utils",
    "ca-certificates",
    "ubuntu-keyring",
    "lsb-release",
    "iproute2",
    "supervisor",
    "bash",
    "curl",
    "wget",
    "git",
    "nvi",
    "nano",
    "pv",
    "jq",
    "zip",
    "unzip",
    "gpg",
    "gnupg",
    "gnupg2",
    "pwgen",
    "cron",
    "dos2unix",
    "inotify-tools",
    "locales",
    "tzdata"
  ]
}
