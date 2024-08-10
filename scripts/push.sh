#!/usr/bin/env bash

source ./scripts/_config.sh

for ubuntu in {"20.04","22.04"}; do
    echo " ==> pushing ${REPOSITORY}:${ubuntu}"
    docker push "${REPOSITORY}:${ubuntu}"
done
