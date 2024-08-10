#!/usr/bin/env bash

function is_false() {
	case "${@^^}" in
	0|F|FA|FAL|FALS|FALSE|N|NO|NOT)
		return 0
		;;
	*)
		return 1
		;;
	esac
}

function is_true() {
	if is_false $@; then
		return 1
	fi
	return 0
}
