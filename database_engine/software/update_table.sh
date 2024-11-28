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


#=====================================================




read -p "Enter the primary key of the row to update: " pk_value
read -p "Enter the column number to update: " col_num
read -p "Enter the new value: " new_value


num_columns=$(awk 'NR == 2 {print NF}' "$table")  # Assumes column headers are on the 2nd line

# Check if the column number is valid
if [[ "$col_num" -le 0 || "$col_num" -gt "$num_columns" ]]; then
    echo "Error: Column number $col_num is out of range. Valid range is 1 to $num_columns."
    exit 1
fi

# Check if the primary key exists in the table
if grep -q "^$pk_value\b" <(awk '{print $1}' "$table" | tail -n +2); then
    echo "Primary key $pk_value exists."

    # Locate the row to update and modify the specific column
    awk -v pk="$pk_value" -v col="$col_num" -v value="$new_value" '
    NR > 2 && $1 == pk {  # Skip header rows and locate the matching PK row
        $col = value      # Update the specified column
        print $0          # Print the updated row
        next
    }
    { print $0 }          # Keep all other lines unchanged
    ' "$table" > tmpfile && mv tmpfile "$table"

    echo "Cell updated successfully."
else
    echo "Error: Primary key $pk_value does not exist."
    exit 1
fi






