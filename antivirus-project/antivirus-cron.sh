#!/bin/bash

		if [ "$#" -ne 2 ]; then
			echo "Error!!! Provide $0 dir malicious_dir"
			exit 1
		fi

dir="$1"
malicious_dir="$2"


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

scan_directory
