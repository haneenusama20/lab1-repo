#!/bin/bash
	if [ "$#" -ne 3 ]; then
		echo "Error !! Provide:  $0 dir malicious_dir interval-secs"
		exit 1
	fi
dir="$1"
malicious_dir="$2"
interval_secs="$3"

last = "directory-info.last"
new = "directory-info.new"


