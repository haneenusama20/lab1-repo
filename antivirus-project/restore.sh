#!/bin/bash

	if [ "$#" -ne 2 ]; then
		echo "Error!! Provide: $0 dir maliciour_dir"
	exit 1
	fi

dir="$1"
malicious_dir="$2"






while true
do
	files=($(ls "$malicious_dir"))

if [ "${#files[@]}" -eq 0 ]; then
	echo "No malicious files to review"
	exit 0
fi

i=1

for file in "${files[@]}"
do
	echo "$i) $(basename "$file")"
	((i++))
done

read -p "Choose a file by number: " choice
index=$((choice-1))

selectedfile="$malicious_dir/${files[$index]}"

echo "1) Restore this file back into dir (it was a false positive)"
echo "2) Permenantly delete this file from malicious_dir (it was geniuely malicious)"
echo "3) Leave as-is"

read -p "Choose an option: " option

		case "$option" in
		1)
			mv "$selectedfile" "$dir/"
			echo "Restored $(basename  "$selectedfile") to "$dir""
		;;
		2)
			rm "$selectedfile"
			echo "$(basename "$selectedfile") permenantly deleted"

		;;

		3)
			continue
		;;

		esac 




done
