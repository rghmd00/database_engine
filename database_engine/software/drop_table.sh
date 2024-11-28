#!bin/bash



list=(`ls`)

if [[ -z "$(ls -A)" ]]; then
    echo "No tables available to drop"
    exit 0
fi



echo "already existing tables :"
echo "${list[@]}"
read -p "type the name of the table in order to drop it :" drop_table


if [[ -e "$drop_table" ]]; then
    echo "$drop_table is dropped"
    rm -r "$drop_table"
else
    echo "The table does not exist."
fi
