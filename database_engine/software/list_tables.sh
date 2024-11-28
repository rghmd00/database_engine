#!/bin/bash



#deleting tables that has no meta data
DIRECTORY="."

for file in "$DIRECTORY"/*; do
    if [ -f "$file" ] && [ ! -s "$file" ]; then
        rm -r "$file"
    fi
done




if [ -z "$(ls -A .)" ]; then
    echo "there are no tables in the selected database"
else
    list=(`ls`)
    echo "${list[@]}"
fi



