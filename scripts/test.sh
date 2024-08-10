#!/usr/bin/env bash

source ./scripts/_config.sh

UBUNTU_VERSIONS=(20.04 22.04)
UBUNTU_VERSION="$1"
CMD="$2" # Empty for default command or /bin/bash

if ! [[ "${UBUNTU_VERSIONS[*]}" =~ "$UBUNTU_VERSION" ]] || [[ -z "$UBUNTU_VERSION" ]]; then
    echo "Unsupported Ubuntu version: \"$UBUNTU_VERSION\""
    exit 1
fi

# Generate list of files to mount into the containers so that changes can be tested without rebuilding each time
VOLUMES=""
for item in $(find $(pwd)/src/rootfs -type f); do
    VOLUMES="${VOLUMES} --volume=${item}:${item##$(pwd)/src/rootfs}"
done

# Run docker
if [[ -z "$CMD" ]]; then
    docker run \
        --tty \
        --interactive \
        --rm \
        --name "ubuntu-${UBUNTU_VERSION/./-}" \
        --env "EXPAND_FROM_ENV_DEBUG_VALUES=true" \
        $VOLUMES \
            "${REPOSITORY}:${UBUNTU_VERSION}"
else
    docker run \
        --tty \
        --interactive \
        --rm \
        --name "ubuntu-${UBUNTU_VERSION/./-}" \
        --env "EXPAND_FROM_ENV_DEBUG_VALUES=true" \
        $VOLUMES \
            "${REPOSITORY}:${UBUNTU_VERSION}" "$CMD"
fi
