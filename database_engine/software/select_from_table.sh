#!/bin/bash


#deleting tables that has no meta data
DIRECTORY="."

for file in "$DIRECTORY"/*; do
    if [ -f "$file" ] && [ ! -s "$file" ]; then
        rm -r "$file"
    fi
done

#==============================================





list=(`ls`)

if [[ -z "$(ls -A)" ]]; then
    echo "No tables available"
    exit 0
fi



echo "already existing tables :"
echo "${list[@]}"
read -p "type the name of the table in order to select data :" table

#=========================
	num_columns=$(awk '{print NF}' "$table")
	read -a column_types <<< "$(awk 'NR==1 {print}' "$table")"
	read -a column_names <<< "$(awk 'NR==2 {print}' "$table")"

	
	let num=$num_columns
#=========================



if [[ -e "$table" ]]; then
	#display table
	awk -v num="$num" '
NR > 1 { # Start processing from the second row
    for (i = 1; i <= num; i++) {
        printf "%s", $i
        if (i < num) {
            printf " | "
        }
    }
    printf "\n"
}' "$table"
	
	
	
	
	else
	echo "table does not exists "
	exit 0
fi





