#!/bin/bash

cd ../schemas



if [ -z "$(ls -A )" ]; then
    echo "There are no available databases "

else




databases=(`ls -F | grep / | tr / " "`)
echo "existing schemas: ${databases[@]}"

read -p "type the name of schema to start connection : " con

if [[ "${#databases[@]}" -eq 0 ]];then
        echo "No schemas available to connect"
        exit 0


elif [[ -d "$con" ]]; then
        echo "connecting $con"
	cd ../schemas/"$con"
	
echo "choose schema update from the following : "	
select choice in create_table list_tables drop_table insert_into_table select_from_table delete_from_table update_table
do
case "$choice" in
	create_table)
			source ../../software/create_table.sh
			break;;
	list_tables)
                        source ../../software/list_tables.sh
			break;;
	drop_table)
                        source ../../software/drop_table.sh
			break;;
	insert_into_table)
                     	source ../../software/insert_into_table.sh
			break;;
        select_from_table)
                        source ../../software/select_from_table.sh
			break;;
        delete_from_table)
                        source ../../software/delete_from_table.sh
			break;;
	update_table)
                        source ../../software/update_table.sh
			break;;
esac
done


else
    	echo "Error: schema does not exist..."
fi

fi



cd - >/dev/null
















