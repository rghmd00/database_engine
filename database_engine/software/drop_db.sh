#!/bin/bash

cd ../schemas


if [ -z "$(ls -A )" ]; then
    echo "There are no available databases "

else


databases=(`ls -F | grep / | tr / " "`)
echo "${databases[@]}"

read -p "type the name of the database to drop : " drop



if [[ "${#databases[@]}" -eq 0 ]];then
	echo "No databases available to drop"
	exit 0
elif [[ -d "$drop" ]]; then
	echo "dropping $drop"
	rm -r "$drop"
	exit 0
else
	echo "Error: database does not exist..."
fi
fi



cd - >/dev/null

