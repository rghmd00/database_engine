#! /usr/bin/bash


select choice in CREATE_DB LIST_DB CONNECT_DB DROP_DB
do 
case $choice in
CREATE_DB)
	
	./create_db.sh
	break;;
LIST_DB)
	./list_db.sh
	break;;
CONNECT_DB)
	./connect_db.sh
	break;;
DROP_DB)
	./drop_db.sh
	break;;
esac
done
