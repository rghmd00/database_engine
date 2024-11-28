#!bin/bash


#deleting tables that has no meta data
DIRECTORY="."

for file in "$DIRECTORY"/*; do
    if [ -f "$file" ] && [ ! -s "$file" ]; then
        rm -r "$file"
    fi
done
#=================================================

list=(`ls`)

if [[ -z "$(ls -A)" ]]; then
    echo "No tables available"
    exit 0
fi



echo "already existing tables :"
echo "${list[@]}"
read -p "type the name of the table in order to insert data :" table



#=================
new_row=()
#================


if [[ -e "$table" ]]; then
	#display table
	sed -n '1,2p' "$table"

	num_columns=$(awk '{print NF}' "$table")
	read -a column_types <<< "$(awk 'NR==1 {print}' "$table")"
	read -a column_names <<< "$(awk 'NR==2 {print}' "$table")"

	
	let num=$num_columns

#=========================================================================
    for (( i=0; i < num; i++ )); do
	while true; do
            read -p "Enter value for column $i : " value
            
            #==================================
            
            if [[ i==0 ]];then
            if grep -q "^$value\b" <(awk '{print $1}' "$table" | tail -n +2); then
    		echo "Primary key $value already exists. Please insert a unique value."
    		continue
	    else
    		echo "Primary key $value is unique. You can proceed with the insertion."
    		new_row+="$value "
    		break
	    fi
	    fi
            # Validate based on column type
            case "${column_types[i]}" in
                "number")
                    if [[ "$value" =~ ^[0-9]+$ ]]; then
                        new_row+="$value "
                        break
                    else
                        echo "Invalid input. Please enter a numeric value."
                    fi
                    ;;
                "text")
                    if [[ "$value" =~ ^[a-zA-Z]+$ ]]; then
                        new_row+="$value "
                        break
                    else
                        echo "Invalid input. Please enter a string value."
                    fi
                    ;;
                *)
                    echo "Unknown column type: ${column_types[i]}"
                    exit 1
                    ;;
            esac
        done
    done
    
#===========================================================================
else
    echo "The table does not exist"
    exit 
fi


#==================

echo "${new_row[@]}" >> "$table"

