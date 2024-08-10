# docker-dev-ubuntu
[WIP] Docker ubuntu development image

## Project structure
 - /scripts/* - Various scripts used to build and test images.
 - /src/*.pkr.hcl - Packer build instructions, some of these files might be generated from a template.
 - /src/scripts/*.sh - Image build scripts, these are run inside the build container to create the image, used will install packages and set file permissions.
 - /src/rootfs/ - Image files, these will be added to the image, includes various bootstrap scripts, process configuration, utilities, etc...
 - /test/ - created by the /scripts/test.sh script, various mutable directories are mounted here to test scenarios.
