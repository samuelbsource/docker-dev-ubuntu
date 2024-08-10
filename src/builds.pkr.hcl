build {
  sources = [
    "source.docker.ubuntu-20-04",
    "source.docker.ubuntu-22-04"
  ]

  provisioner "file" {
    source = trimprefix("${trimprefix(abspath(path.root), abspath(path.cwd))}/rootfs", "/")
    destination = "/tmp/rootfs"
  }

  provisioner "shell" {
    scripts = fileset(abspath(path.cwd), trimprefix("${trimprefix(abspath(path.root), abspath(path.cwd))}/scripts/*.sh", "/"))
    env = {
        PACKER_ENV_PACKAGES = join(" ", local.packages)
    }
  }

  post-processor "docker-tag" {
    repository = var.repository
    tags = ["20.04"]
    only = ["docker.ubuntu-20-04"]
  }

  post-processor "docker-tag" {
    repository = var.repository
    tags = ["22.04"]
    only = ["docker.ubuntu-22-04"]
  }
}