#!/usr/bin/env bash
# usage: ./link-script.sh path/to/file

for path in "$@"
do
    echo "$path" | awk '
        BEGIN {FS="/"}

        {
            print $NF
        }
    ' | xargs ln -s "$path"  

done