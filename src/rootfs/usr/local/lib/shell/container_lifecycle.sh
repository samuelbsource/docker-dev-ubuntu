#!/usr/bin/env bash

function run_entrypoint_scripts () {
    for script in /etc/docker-entrypoint.d/*.sh; do
        if [ -f "$script" ]; then
            echo " ==> Running \"${script}\" ... "
            . "$script"
        fi
    done
}

function run_reloadpoint_scripts () {
    for script in /etc/docker-reloadpoint.d/*.sh; do
        if [ -f "$script" ]; then
            echo " ==> Running \"${script}\" ... "
            . "$script"
        fi
    done
}

function run_exitpoint_scripts () {
    for script in /etc/docker-exitpoint.d/*.sh; do
        if [ -f "$script" ]; then
            echo " ==> Running \"${script}\" ... "
            . "$script"
        fi
    done
}
