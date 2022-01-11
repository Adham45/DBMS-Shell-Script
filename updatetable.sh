#!/bin/bash

updateTable_menu()
{
options=("Delete Column" "Delete Record" "Back to main menu")
 while [[ "$option" != "Back to main menu" ]]
do
select option in "${options[@]}"
do
  case $option in
       "Delete Column") . ./delete_column.sh; break ;;
       "Delete Record") . ./delete_record.sh; break ;;
       "Back to main menu") . ./mainmenu.sh; break ;;
       *) echo "Not Valid Option $REPLY" ;;
  esac
done
done
}

read -p "Enter Table Name :" tableName;

if [[ -f Databases/$currdb/data/$tableName ]]
then
    export tableName=$tableName;
    echo "$tableName is selected"
    updateTable_menu;
else
    echo "Table does not exist";
fi
