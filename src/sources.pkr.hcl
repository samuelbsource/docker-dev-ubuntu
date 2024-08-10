source "docker" "ubuntu-20-04" {
  image = "ubuntu:20.04"
  commit = true
  pull = true
  changes = [
    "ENTRYPOINT [\"${local.image_entrypoint}\"]",
    "CMD [\"${join("\", \"", local.image_default_command)}\"]",
    "WORKDIR /",
    "LABEL org.opencontainers.image.title=\"Ubuntu 20.04\"",
    "LABEL org.opencontainers.image.description=\"Base Ubuntu image for derivative builds.\"",
    "LABEL org.opencontainers.image.base.name=${var.repository}:20.04",
    "LABEL org.opencontainers.image.authors=\"${join(", ", local.authors)}\"",
    "LABEL org.opencontainers.image.created=${timestamp()}",
    "LABEL org.opencontainers.image.version=20.04",
    "LABEL org.opencontainers.image.source=\"${local.source}\""
  ]
}

source "docker" "ubuntu-22-04" {
  image = "ubuntu:22.04"
  commit = true
  pull = true
  changes = [
    "ENTRYPOINT [\"${local.image_entrypoint}\"]",
    "CMD [\"${join("\", \"", local.image_default_command)}\"]",
    "WORKDIR /",
    "LABEL org.opencontainers.image.title=\"Ubuntu 22.04\"",
    "LABEL org.opencontainers.image.description=\"Base Ubuntu image for derivative builds.\"",
    "LABEL org.opencontainers.image.base.name=${var.repository}:22.04",
    "LABEL org.opencontainers.image.authors=\"${join(", ", local.authors)}\"",
    "LABEL org.opencontainers.image.created=${timestamp()}",
    "LABEL org.opencontainers.image.version=22.04",
    "LABEL org.opencontainers.image.source=\"${local.source}\""
  ]
}
