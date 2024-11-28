#!/bin/bash

#table name code



function validate_name()
{
	case "$table_name" in
	'')
		echo "table name can not be empty!"
		return 0
	;;
	[0-9]*)
		echo "table name can not start with a number"
		return 0
	;;
	*[[:space:]]*)
		echo "table name can not include space"
		return 0
	;;
	*[!a-zA-Z0-9_]*)
            echo "table name can only contain letters, numbers, and underscores."
            return 0
        ;;
	[a-zA-Z_0-9]*)
	    touch "$table_name"
            echo "table '$table_name' created successfully!"
            return 1
        ;;    

	*)
            echo "Invalid table name"
        ;;
	esac

}

#===============================================================
list=(`ls`)    	 
echo "Already existing tables in schema: " "${list[@]}"
while true
do 
read -p "table name : " table_name

if [[ -e "$table_name" ]]; then
        echo "Error: table $table_name already exists"
        continue
else
	validate_name "$table_name"
	break
fi
done

#number of columns code
#=======================================================================================

while true;
do
read -p "Enter the number of feilds for $table_name : " num

if [[ "$num" =~ ^[0-9]+$ && "$num" -gt 0 ]];then
	echo " $num is a valid number "
	break
else
	echo "please Enter valid number"
	continue
fi

done

#========================================================================================
#columns_names and types
#========================================================================================
declare -a columns
declare -a column_types

columns+=("PK")
column_types+=("text")

for ((i=1;i<=num;i++));do
	while true;do
	read -p "Enter a valid name for column $i: " col_name

		# Check if column already exists in the array
        	if printf "%s\n" "${columns[@]}" | grep -q "^$col_name$"; then
           	 echo "Invalid: Column name '$col_name' already exists."
            	continue
       		 fi
		#=============================================================
		
		case "$col_name" in
		'')
		echo "Invalid Column name can not be empty"
		continue;;
		[0-9]*)
		echo "Invalid Column name can not start with numbers"
		continue;;
		*[[:space:]]*)
		echo "Invalid Column name can not contain space"
		continue;;
		*[!a-zA-Z0-9_]*)
		echo "Invalid column name use letters only"
		continue;;
		[a-zA-Z_]*)
		echo "vaild column name"
		columns+=("$col_name")

		#===================================================================
		
		select type in "Number" "Text"; do
		    case $type in
		    "Number")
			echo "$col_name type is number"
			column_types+=("number")
			break
			;;
		    "Text")
			echo "$col_name type is text"
			column_types+=("text")
			break
			;;
		    *)
			echo "Invalid option. Please select 1 for number or 2 for text."
			;;
		    esac
		done

		#===================================================================
		break;;
		*)
		echo "Invaild Column name"
		continue;;
		esac
	done
done


#==============================================


echo "${column_types[@]}" >> "$table_name"
echo "${columns[@]}" >> "$table_name"


#=================================================








