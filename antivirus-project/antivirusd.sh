#!/bin/bash
	if [ "$#" -ne 3 ]; then
		echo "Error !! Provide:  $0 dir malicious_dir interval-secs"
		exit 1
	fi
dir="$1"
malicious_dir="$2"
interval_secs="$3"

last="directory-info.last"
new="directory-info.new"

scan_directory()
{
	for file in "$dir"/*
	do
		if [ -f "$file" ]; then

			case "$file" in
				*.exe|*.bat|*.vbs|*.scr|*.ps1)

					echo "$file is malicious and it is DELETED"
					cp "$file" "$malicious_dir/"
					rm "$file"
					continue
				;;

			esac

			if grep -qiE 'virus|trojan|malware|worm|ransomware'  "$file"; then
					echo "$file is malicious and it is DELETED"
					cp "$file" "$malicious_dir/"
					rm "$file"
			fi

		fi

	done
}


if [ ! -f "$last" ]; then
	scan_directory
	ls -l "$dir" > "$last"
fi


while true
do

	sleep "$interval_secs"

	ls -l "$dir" > "$new"

	if cmp -s "$last" "$new"; then

	continue

	fi

	scan_directory
	ls -l "$dir" > "$last"

done
