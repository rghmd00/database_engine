#!/bin/bash
cd ../schemas


function validate_name()
{
	case "$db_name" in
	'')
		echo "Database name can not be empty!"
		return 0
	;;
	[0-9]*)
		echo "Database name can not start with a number"
		return 0
	;;
	*[[:space:]]*)
		echo "Database name can not include space"
		return 0
	;;
	*[!a-zA-Z0-9_]*)
            echo "Database name can only contain letters, numbers, and underscores."
            return 0
        ;;
	[a-zA-Z_0-9]*)
	    mkdir -p "$db_name"
            echo "Database '$db_name' created successfully!"
            return 1
        ;;    

	*)
            echo "Invalid database name"
        ;;
	esac

}


while true;do
echo "Insert your DataBase name: "
read db_name

	if [[ -d "$db_name" ]];then
		echo "Error : db_name already exists"
		continue
	else
	
		validate_name "$db_name"
		break
	
fi
done
cd - >/dev/null




