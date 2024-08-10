#!/usr/bin/env bash

source ./scripts/_config.sh

packer init ./src
packer build -var "repository=$REPOSITORY" ./src
