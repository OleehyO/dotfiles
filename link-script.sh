#!/usr/bin/env bash
# usage: ./link-script.sh path/to/file
#+ （要将link-script.sh放在～目录下）

for path in "$@"
do
    echo "$path" | awk '
        BEGIN {FS="/"}

        {
            if ($NF != ".git") {
                print $NF
            } 
        }
    ' | xargs ln -s "$path"  

done