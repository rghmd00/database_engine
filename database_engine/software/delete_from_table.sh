#!bin/bash


list=(`ls`)

if [[ -z "$(ls -A)" ]]; then
    echo "No tables available"
    exit 0
fi

#===================================================


#deleting tables that has no meta data
DIRECTORY="."

for file in "$DIRECTORY"/*; do
    if [ -f "$file" ] && [ ! -s "$file" ]; then
        rm -r "$file"
    fi
done

#====================================================

echo "already existing tables :"
echo "${list[@]}"
read -p "type the name of the table in order to delete data using PK : " table

read -p "Insert primary key in order to delete data : " PK_TO_DELETE


# Check if the PK exists
if ! awk -v pk="$PK_TO_DELETE" '$1 == pk {exit 0}' "$table"; then
    echo "Error: No row found with primary key '$PK_TO_DELETE'."
    exit 1
fi


# Filter out the line with the matching primary key and overwrite the file
awk -v pk="$PK_TO_DELETE" '$1 != pk {print $0}' "$table" > temp && mv temp "$table"

<'COMMENT'
echo "Line with primary key $PK_TO_DELETE has been deleted."
COMMENT
